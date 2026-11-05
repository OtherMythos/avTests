//What a ticket allows in each of its states: empty, in flight, finished and mapped.

const SIZE = 8;
const CYCLES = 20;
const LARGE_SIZE = 2048;
const PIXEL = 0x112233FF;

function solidPixel(x, y){ return PIXEL; }

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::texture <- createTicketTexture("ticketTexture", SIZE, SIZE);
    uploadPixels(::texture, solidPixel);
    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);

    //Empty: it reports done, as Ogre's does, with nothing there to read.
    _test.assertTrue(::ticket.queryIsTransferDone());
    assertThrows(function(){ ::ticket.map(0); }, "Nothing has been downloaded.");
    assertThrows(function(){ ::ticket.unmap(); }, "Ticket is not mapped.");

    //map waits for a download which hasn't finished.
    ::ticket.download(::texture, 0, true);
    local box = ::ticket.map(0);
    _test.assertEqual(readPixel(box, 3, 3), PIXEL);
    _test.assertTrue(::ticket.queryIsTransferDone());

    assertThrows(function(){ ::ticket.map(0); }, "Ticket is already mapped.");
    assertThrows(function(){ ::ticket.download(::texture, 0, true); }, "Ticket is mapped: call unmap first.");

    ::ticket.unmap();
    assertThrows(function(){ ::ticket.unmap(); }, "Ticket is not mapped.");

    //A download can be read any number of times.
    box = ::ticket.map(0);
    _test.assertEqual(readPixel(box, 5, 5), PIXEL);
    ::ticket.unmap();

    checkInFlightRefused();

    ::cycle <- 0;
    ::ticket.download(::texture, 0, true);
}

//Vulkan's download can return with the copy already finished, leaving nothing to
//refuse, so this only asks it of a copy seen to be going. That one is large so it
//can't finish between two calls from script, and over several tries in case it does.
function checkInFlightRefused(){
    local texture = createTicketTexture("largeTexture", LARGE_SIZE, LARGE_SIZE);
    local ticket = _graphics.createAsyncTextureTicket(LARGE_SIZE, LARGE_SIZE, _PFG_RGBA8_UNORM);
    local seen = 0;
    local refused = 0;
    for(local i = 0; i < 5; i++){
        ticket.download(texture, 0, true);
        if(!ticket.queryIsTransferDone()){
            seen++;
            try{
                ticket.download(texture, 0, true);
            }catch(e){
                _test.assertEqual(e, "A download is still in flight.");
                refused++;
            }
        }
        //Waits for whichever is going.
        ticket.map(0);
        ticket.unmap();
    }
    _test.assertEqual(seen > 0, refused > 0);
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    //Done stays done until the next download.
    _test.assertTrue(::ticket.queryIsTransferDone());
    _test.assertTrue(::ticket.queryIsTransferDone());

    local box = ::ticket.map(0);
    _test.assertEqual(readPixel(box, 3, 3), PIXEL);
    ::ticket.unmap();

    ::cycle++;
    if(::cycle == CYCLES){
        _test.endTest();
        return;
    }
    ::ticket.download(::texture, 0, true);
}
