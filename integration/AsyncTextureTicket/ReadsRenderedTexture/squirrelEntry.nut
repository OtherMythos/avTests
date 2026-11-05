//A download issued from update, after the compositor has run, returns what was
//drawn into the texture: a square up in the top left of the picture, on the clear
//colour. Read in picture space, so the row order is pinned on every render system.

const SIZE = 64;

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::texture <- createTicketTexture("ticketTexture", SIZE, SIZE);
    ::workspace <- renderSceneInto(::texture);
    //Covers pixels 8..24 of the picture on both axes.
    ::square <- createIdSquare("ticketSquare", 200, -16, 16, 0, 8);

    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::ticket.download(::texture, 0, true);
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    //Until the workspace first reaches it the texture holds whatever its memory did.
    if(readPixel(box, 16, 16) != 0xC80000FF){
        ::ticket.unmap();
        ::ticket.download(::texture, 0, true);
        return;
    }

    _test.assertEqual(readPixel(box, 9, 9), 0xC80000FF);
    _test.assertEqual(readPixel(box, 23, 23), 0xC80000FF);
    _test.assertEqual(readPixel(box, 26, 16), 0);
    _test.assertEqual(readPixel(box, 16, 26), 0);
    _test.assertEqual(readPixel(box, 16, 48), 0);
    _test.assertEqual(readPixel(box, 48, 16), 0);
    ::ticket.unmap();

    _test.endTest();
}
