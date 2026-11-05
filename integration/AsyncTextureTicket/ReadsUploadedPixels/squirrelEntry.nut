//Downloading a texture filled from the CPU returns every pixel exactly, with
//(0, 0) as the first row and column written. A wide texture, so x and y can't be
//confused, with no two pixels alike.

const WIDTH = 16;
const HEIGHT = 8;

function patternPixel(x, y){
    return ((x + 1) << 24) | ((y + 1) << 16) | ((x * 13 + y * 7) << 8) | 0xFF;
}

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::texture <- createTicketTexture("ticketTexture", WIDTH, HEIGHT);
    uploadPixels(::texture, patternPixel);

    ::ticket <- _graphics.createAsyncTextureTicket(WIDTH, HEIGHT, _PFG_RGBA8_UNORM);
    _test.assertEqual(::ticket.getWidth(), WIDTH);
    _test.assertEqual(::ticket.getHeight(), HEIGHT);
    ::ticket.download(::texture, 0, true);
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    _test.assertEqual(readPixel(box, 0, 0), 0x010100FF);
    _test.assertEqual(readPixel(box, WIDTH - 1, 0), 0x1001C3FF);
    for(local y = 0; y < HEIGHT; y++){
        for(local x = 0; x < WIDTH; x++){
            _test.assertEqual(readPixel(box, x, y), patternPixel(x, y));
        }
    }
    ::ticket.unmap();

    _test.endTest();
}
