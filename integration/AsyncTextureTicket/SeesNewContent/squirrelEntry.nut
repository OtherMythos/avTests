//A ticket holds the copy it took, not the texture: changing what's drawn doesn't
//reach it until the next download. The texture keeps rendering after being copied
//from, which is the layout a render system has to get right.

const SIZE = 16;
const SECOND_ID = 20;
const FIRST_PIXEL = 0x0A0000FF;
const SECOND_PIXEL = 0x140000FF;

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::texture <- createTicketTexture("ticketTexture", SIZE, SIZE);
    ::workspace <- renderSceneInto(::texture);
    ::square <- createIdSquare("ticketSquare", 10, 0, 0, 0, 4);
    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::ticket.download(::texture, 0, true);
    ::changed <- false;
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    local pixel = readPixel(box, 8, 8);
    local corner = readPixel(box, 0, 0);
    ::ticket.unmap();

    if(!::changed){
        //Until the workspace first reaches it the texture holds whatever its memory did.
        if(pixel == FIRST_PIXEL){
            setSquareId("ticketSquare", SECOND_ID);
            ::changed = true;

            local again = ::ticket.map(0);
            _test.assertEqual(readPixel(again, 8, 8), FIRST_PIXEL);
            ::ticket.unmap();
        }
    }else if(pixel != FIRST_PIXEL){
        _test.assertEqual(pixel, SECOND_PIXEL);
        _test.assertEqual(corner, 0);
        _test.endTest();
        return;
    }

    ::ticket.download(::texture, 0, true);
}
