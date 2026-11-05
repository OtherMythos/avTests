//One ticket reused for a long run of downloads of a changing texture, as a game does
//for as long as a drag lasts. Each download is exactly one of the ids the texture
//could have held, never a mixture, and it keeps up with the changes.

const SIZE = 32;
const CYCLES = 200;

function idForCycle(cycle){ return (cycle % 127) + 1; }

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::texture <- createTicketTexture("ticketTexture", SIZE, SIZE);
    ::workspace <- renderSceneInto(::texture);
    ::square <- createIdSquare("ticketSquare", idForCycle(0), 0, 0, 0, SIZE);
    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::ticket.download(::texture, 0, true);
    ::cycle <- 0;
}

function checkFlat(box, wanted){
    //A flat colour, so every corner has to agree with the middle.
    _test.assertEqual(readPixel(box, SIZE - 1, 0), wanted);
    _test.assertEqual(readPixel(box, 0, SIZE - 1), wanted);
    _test.assertEqual(readPixel(box, SIZE - 1, SIZE - 1), wanted);
    _test.assertEqual(readPixel(box, SIZE / 2, SIZE / 2), wanted);
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    local pixel = readPixel(box, 0, 0);
    local wanted = (idForCycle(::cycle) << 24) | 0xFF;

    if(pixel == wanted){
        checkFlat(box, wanted);
        ::cycle++;
        if(::cycle < CYCLES) setSquareId("ticketSquare", idForCycle(::cycle));
    }else if(::cycle > 0){
        //Not reached the texture yet, so it's the last cycle's. Before the first, the
        //texture holds whatever its memory did until the workspace reaches it.
        _test.assertEqual(pixel, (idForCycle(::cycle - 1) << 24) | 0xFF);
    }
    ::ticket.unmap();

    if(::cycle == CYCLES){
        _test.endTest();
        return;
    }
    ::ticket.download(::texture, 0, true);
}
