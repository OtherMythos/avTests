//A ticket and the texture it downloads can go away in either order at any point in
//a transfer, including the engine shutting down with one in flight or mapped.

const SIZE = 8;
const PIXEL = 0x778899FF;

function solidPixel(x, y){ return PIXEL; }

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    //Never used.
    {
        local unused = _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    }

    ::texture <- createTicketTexture("ticketTexture", SIZE, SIZE);
    uploadPixels(::texture, solidPixel);

    //Dropped mid-transfer.
    for(local i = 0; i < 20; i++){
        local dropped = _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
        dropped.download(::texture, 0, true);
    }

    //Dropped while mapped.
    {
        local mapped = _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
        mapped.download(::texture, 0, true);
        mapped.map(0);
    }

    //The texture goes first: the copy was already issued, so it still arrives.
    ::doomedTexture <- createTicketTexture("doomedTexture", SIZE, SIZE);
    uploadPixels(::doomedTexture, solidPixel);
    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::ticket.download(::doomedTexture, 0, true);
    _graphics.destroyTexture(::doomedTexture);
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    _test.assertEqual(readPixel(box, 0, 0), PIXEL);
    ::ticket.unmap();

    //Dropped once finished, then the engine shuts down with one in flight and one mapped.
    ::ticket = null;
    ::inFlightAtShutdown <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::inFlightAtShutdown.download(::texture, 0, true);
    ::mappedAtShutdown <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::mappedAtShutdown.download(::texture, 0, true);
    ::boxAtShutdown <- ::mappedAtShutdown.map(0);
    _test.endTest();
}
