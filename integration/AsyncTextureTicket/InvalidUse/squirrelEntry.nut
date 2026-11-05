//Every misuse is a script error rather than a crash, an assert in Ogre or a transfer
//which never finishes, and none of them disturbs the ticket it was tried on.

const SIZE = 8;
const BAD_SIZE = "Width and height must be greater than 0.";
const BAD_FORMAT = "Invalid pixel format provided";
const SIZE_MISMATCH = "Texture does not match the size of this ticket.";
const NO_MIP = "Texture has no such mip level.";
const NO_SLICE = "Ticket has no such slice.";
const PIXEL = 0x445566FF;

function solidPixel(x, y){ return PIXEL; }

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    assertThrows(function(){ _graphics.createAsyncTextureTicket(0, SIZE, _PFG_RGBA8_UNORM); }, BAD_SIZE);
    assertThrows(function(){ _graphics.createAsyncTextureTicket(SIZE, 0, _PFG_RGBA8_UNORM); }, BAD_SIZE);
    assertThrows(function(){ _graphics.createAsyncTextureTicket(-1, SIZE, _PFG_RGBA8_UNORM); }, BAD_SIZE);
    assertThrows(function(){ _graphics.createAsyncTextureTicket(SIZE, -1, _PFG_RGBA8_UNORM); }, BAD_SIZE);
    assertThrows(function(){ _graphics.createAsyncTextureTicket(SIZE, SIZE, -1); }, BAD_FORMAT);
    assertThrows(function(){ _graphics.createAsyncTextureTicket(SIZE, SIZE, 0); }, BAD_FORMAT);
    assertThrows(function(){ _graphics.createAsyncTextureTicket(SIZE, SIZE, 100000); }, BAD_FORMAT);
    assertThrows(function(){ _graphics.createAsyncTextureTicket("wide", SIZE, _PFG_RGBA8_UNORM); });
    assertThrows(function(){ _graphics.createAsyncTextureTicket(SIZE, SIZE); });

    ::texture <- createTicketTexture("ticketTexture", SIZE, SIZE);
    uploadPixels(::texture, solidPixel);
    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);

    local wrongWidth = createTicketTexture("wrongWidth", SIZE * 2, SIZE);
    local wrongHeight = createTicketTexture("wrongHeight", SIZE, SIZE * 2);
    //_graphics.createTexture's own default, RGBA32 float.
    local wrongFormat = _graphics.createTexture("wrongFormat");
    wrongFormat.setResolution(SIZE, SIZE);
    wrongFormat.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);
    local notResident = _graphics.createTexture("notResident");
    notResident.setResolution(SIZE, SIZE);
    notResident.setPixelFormat(_PFG_RGBA8_UNORM);
    local destroyed = createTicketTexture("destroyed", SIZE, SIZE);
    _graphics.destroyTexture(destroyed);

    assertThrows(function(){ ::ticket.download(wrongWidth, 0, true); }, SIZE_MISMATCH);
    assertThrows(function(){ ::ticket.download(wrongHeight, 0, true); }, SIZE_MISMATCH);
    assertThrows(function(){ ::ticket.download(wrongFormat, 0, true); }, "Texture does not match the format of this ticket.");
    assertThrows(function(){ ::ticket.download(notResident, 0, true); }, "Texture is not resident and ready.");
    assertThrows(function(){ ::ticket.download(destroyed, 0, true); }, "Texture is invalid.");
    assertThrows(function(){ ::ticket.download(::texture, 1, true); }, NO_MIP);
    assertThrows(function(){ ::ticket.download(::texture, -1, true); }, NO_MIP);

    assertThrows(function(){ ::ticket.download(1, 0, true); });
    assertThrows(function(){ ::ticket.download("texture", 0, true); });
    assertThrows(function(){ ::ticket.download(::ticket, 0, true); });
    assertThrows(function(){ ::ticket.download(::texture); });
    assertThrows(function(){ ::ticket.download(::texture, 0); });
    assertThrows(function(){ ::ticket.download(::texture, "0", true); });
    assertThrows(function(){ ::ticket.download(::texture, 0, 1); });

    //The window's texture is refused for what it is, whatever its size and format.
    local window = _window.getRenderTexture();
    local forWindow = _graphics.createAsyncTextureTicket(window.getWidth(), window.getHeight(), _PFG_RGBA8_UNORM);
    assertThrows(function(){ forWindow.download(window, 0, true); }, "Only textures created by script can be downloaded.");

    //None of that counted as a download.
    assertThrows(function(){ ::ticket.map(0); }, "Nothing has been downloaded.");
    assertThrows(function(){ forWindow.map(0); }, "Nothing has been downloaded.");

    ::ticket.download(::texture, 0, true);
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    assertThrows(function(){ ::ticket.map(1); }, NO_SLICE);
    assertThrows(function(){ ::ticket.map(-1); }, NO_SLICE);
    assertThrows(function(){ ::ticket.map("0"); });
    assertThrows(function(){ ::ticket.map(); });

    //The earlier failures left it working.
    local box = ::ticket.map(0);
    _test.assertEqual(readPixel(box, 0, 0), PIXEL);
    _test.assertEqual(readPixel(box, SIZE - 1, SIZE - 1), PIXEL);
    ::ticket.unmap();

    _test.endTest();
}
