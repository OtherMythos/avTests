//The TextureBox a ticket hands out reads GPU-mapped memory, so unlike a staging box it
//is read only and dies with the mapping. A stale read is the bug that matters most
//here: Metal's unmap does nothing, so it would pass on a Mac and crash elsewhere.

const WIDTH = 8;
const HEIGHT = 4;
const OUTSIDE = "Position is outside the box.";
const STALE = "This box is no longer mapped.";
const READ_ONLY = "A mapped box is read only.";

function patternPixel(x, y){
    return ((x + 1) << 24) | ((y + 1) << 16) | 0xFF;
}

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::texture <- createTicketTexture("ticketTexture", WIDTH, HEIGHT);
    uploadPixels(::texture, patternPixel);
    ::ticket <- _graphics.createAsyncTextureTicket(WIDTH, HEIGHT, _PFG_RGBA8_UNORM);
    ::ticket.download(::texture, 0, true);
}

function checkBounds(box){
    assertThrows(function(){ box.getColourAt(WIDTH, 0, 0, _PFG_RGBA8_UNORM); }, OUTSIDE);
    assertThrows(function(){ box.getColourAt(0, HEIGHT, 0, _PFG_RGBA8_UNORM); }, OUTSIDE);
    assertThrows(function(){ box.getColourAt(0, 0, 1, _PFG_RGBA8_UNORM); }, OUTSIDE);
    assertThrows(function(){ box.getColourAt(-1, 0, 0, _PFG_RGBA8_UNORM); }, OUTSIDE);
    assertThrows(function(){ box.getColourAt(0, -1, 0, _PFG_RGBA8_UNORM); }, OUTSIDE);
    assertThrows(function(){ box.getColourAt(0, 0, -1, _PFG_RGBA8_UNORM); }, OUTSIDE);
    assertThrows(function(){ box.getColourAt(0, 0, 0, -1); }, "Invalid pixel format provided");
    assertThrows(function(){ box.getColourAt(0, 0, 0, 100000); }, "Invalid pixel format provided");
    //Would read 16 bytes out of a 4 byte pixel.
    assertThrows(function(){ box.getColourAt(WIDTH - 1, HEIGHT - 1, 0, _PFG_RGBA32_FLOAT); }, "Pixel format does not match the box.");
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    _test.assertEqual(readPixel(box, WIDTH - 1, HEIGHT - 1), patternPixel(WIDTH - 1, HEIGHT - 1));
    checkBounds(box);

    assertThrows(function(){ box.writen(0, 'b'); }, READ_ONLY);

    //Anything which takes a box to write through refuses it.
    local staging = _graphics.getStagingTexture(WIDTH, HEIGHT, 1, 1, _PFG_RGBA8_UNORM);
    staging.startMapRegion();
    local stagingBox = staging.mapRegion(WIDTH, HEIGHT, 1, 1, _PFG_RGBA8_UNORM);
    staging.stopMapRegion();
    assertThrows(function(){ staging.upload(box, ::texture, 0); });

    //A staging box gets the same bounds, and can still be written.
    checkBounds(stagingBox);
    stagingBox.writen(0x12, 'b');
    _test.assertEqual(channelToByte(stagingBox.getColourAt(0, 0, 0, _PFG_RGBA8_UNORM).r), 0x12);

    //Failing those left the mapping alone.
    _test.assertEqual(readPixel(box, 0, 0), patternPixel(0, 0));

    ::ticket.unmap();
    assertThrows(function(){ box.getColourAt(0, 0, 0, _PFG_RGBA8_UNORM); }, STALE);

    //Stale stays stale, even with the ticket mapped again.
    local second = ::ticket.map(0);
    assertThrows(function(){ box.getColourAt(0, 0, 0, _PFG_RGBA8_UNORM); }, STALE);
    _test.assertEqual(readPixel(second, 1, 1), patternPixel(1, 1));

    //Dropping a mapped ticket ends the mapping too.
    ::ticket = null;
    assertThrows(function(){ second.getColourAt(0, 0, 0, _PFG_RGBA8_UNORM); }, STALE);

    _test.endTest();
}
