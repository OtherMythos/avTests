//Picking: objects drawn with their id as a flat colour into a
//low resolution texture, then told apart by reading its pixels. Every id a byte can
//hold under 128 has to come back exactly, gaps must read as nothing, and where two
//objects overlap the nearer has to win.

const SIZE = 128;
const CELL = 10;
const COLUMNS = 12;
const IDS = 127;
const BACK_ID = 30;
const FRONT_ID = 60;
const OVERLAP_X = 20;
const OVERLAP_Y = 118;

function worldX(px){ return px - SIZE / 2; }
function worldY(py){ return SIZE / 2 - py; }

function idCentre(id){
    local index = id - 1;
    return { x = index % COLUMNS * CELL + CELL / 2, y = index / COLUMNS * CELL + CELL / 2 };
}

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::texture <- createTicketTexture("ticketTexture", SIZE, SIZE);
    ::workspace <- renderSceneInto(::texture);

    ::squares <- [];
    for(local id = 1; id <= IDS; id++){
        local c = idCentre(id);
        ::squares.append(createIdSquare("idSquare" + id, id, worldX(c.x), worldY(c.y), 0, 4));
    }
    //The nearer first, so a pass with no depth would leave the further on top.
    ::squares.append(createIdSquare("frontSquare", FRONT_ID, worldX(OVERLAP_X), worldY(OVERLAP_Y), 5, 3));
    ::squares.append(createIdSquare("backSquare", BACK_ID, worldX(OVERLAP_X), worldY(OVERLAP_Y), -5, 6));

    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::ticket.download(::texture, 0, true);
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    //Until the workspace first reaches it the texture holds whatever its memory did.
    local first = idCentre(1);
    if(readPixel(box, first.x, first.y) != ((1 << 24) | 0xFF)){
        ::ticket.unmap();
        ::ticket.download(::texture, 0, true);
        return;
    }

    for(local id = 1; id <= IDS; id++){
        local c = idCentre(id);
        _test.assertEqual(readPixel(box, c.x, c.y), (id << 24) | 0xFF);
        //The gap either side of it.
        _test.assertEqual(readPixel(box, c.x + CELL / 2, c.y), 0);
        _test.assertEqual(readPixel(box, c.x, c.y + CELL / 2), 0);
    }

    _test.assertEqual(readPixel(box, OVERLAP_X, OVERLAP_Y), (FRONT_ID << 24) | 0xFF);
    _test.assertEqual(readPixel(box, OVERLAP_X + 2, OVERLAP_Y), (FRONT_ID << 24) | 0xFF);
    _test.assertEqual(readPixel(box, OVERLAP_X + 5, OVERLAP_Y), (BACK_ID << 24) | 0xFF);
    _test.assertEqual(readPixel(box, OVERLAP_X - 5, OVERLAP_Y), (BACK_ID << 24) | 0xFF);
    _test.assertEqual(readPixel(box, OVERLAP_X + 8, OVERLAP_Y), 0);
    ::ticket.unmap();

    _test.endTest();
}
