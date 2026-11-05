//Without accurate tracking nothing is flushed, and a download finishes a few frames
//later than it could have. It still has to finish, and read the same.

const SIZE = 8;
const DOWNLOADS = 3;
const PIXEL = 0x224466FF;

function solidPixel(x, y){ return PIXEL; }

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::texture <- createTicketTexture("ticketTexture", SIZE, SIZE);
    uploadPixels(::texture, solidPixel);
    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::ticket.download(::texture, 0, false);
    ::finished <- 0;
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    _test.assertEqual(readPixel(box, 4, 4), PIXEL);
    ::ticket.unmap();

    ::finished++;
    if(::finished == DOWNLOADS){
        _test.endTest();
        return;
    }
    ::ticket.download(::texture, 0, false);
}
