//A ticket isn't tied to RGBA8. It takes any format with a family to match the
//texture's, read back through the box in that format.

const WIDTH = 8;
const HEIGHT = 4;

function makeTexture(name, format){
    local texture = _graphics.createTexture(name);
    texture.setResolution(WIDTH, HEIGHT);
    texture.setPixelFormat(format);
    texture.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);
    return texture;
}

function floatPixel(x, y){ return x * 0.5 + y * 16.0; }
function bytePixel(x, y){ return x * 8 + y * 64; }

function fill(texture, format, writePixel){
    local staging = _graphics.getStagingTexture(WIDTH, HEIGHT, 1, 1, format);
    staging.startMapRegion();
    local box = staging.mapRegion(WIDTH, HEIGHT, 1, 1, format);
    for(local y = 0; y < HEIGHT; y++){
        for(local x = 0; x < WIDTH; x++) writePixel(box, x, y);
    }
    staging.stopMapRegion();
    staging.upload(box, texture, 0);
    texture.barrierSolveTexture();
}

function start(){
    _doFile("res://../../../Resources/scripts/asyncTextureTicket.nut");

    ::floats <- makeTexture("floats", _PFG_RGBA32_FLOAT);
    fill(::floats, _PFG_RGBA32_FLOAT, function(box, x, y){
        box.writen(floatPixel(x, y), 'f');
        box.writen(0.0, 'f');
        box.writen(0.0, 'f');
        box.writen(1.0, 'f');
    });
    ::singleChannel <- makeTexture("singleChannel", _PFG_R8_UNORM);
    fill(::singleChannel, _PFG_R8_UNORM, function(box, x, y){ box.writen(bytePixel(x, y), 'b'); });
    //The same family as RGBA8, so its bytes come back as they were stored.
    ::srgb <- makeTexture("srgb", _PFG_RGBA8_UNORM_SRGB);
    fill(::srgb, _PFG_RGBA8_UNORM_SRGB, function(box, x, y){
        box.writen(bytePixel(x, y), 'b');
        box.writen(0, 'b');
        box.writen(0, 'b');
        box.writen(0xFF, 'b');
    });

    ::floatTicket <- _graphics.createAsyncTextureTicket(WIDTH, HEIGHT, _PFG_RGBA32_FLOAT);
    ::floatTicket.download(::floats, 0, true);
    ::singleTicket <- _graphics.createAsyncTextureTicket(WIDTH, HEIGHT, _PFG_R8_UNORM);
    ::singleTicket.download(::singleChannel, 0, true);
    ::srgbTicket <- _graphics.createAsyncTextureTicket(WIDTH, HEIGHT, _PFG_RGBA8_UNORM);
    ::srgbTicket.download(::srgb, 0, true);
}

function update(){
    if(!::floatTicket.queryIsTransferDone() || !::singleTicket.queryIsTransferDone() || !::srgbTicket.queryIsTransferDone()) return;

    local floatBox = ::floatTicket.map(0);
    local singleBox = ::singleTicket.map(0);
    local srgbBox = ::srgbTicket.map(0);
    for(local y = 0; y < HEIGHT; y++){
        for(local x = 0; x < WIDTH; x++){
            _test.assertEqual(floatBox.getColourAt(x, y, 0, _PFG_RGBA32_FLOAT).r, floatPixel(x, y));
            _test.assertEqual(channelToByte(singleBox.getColourAt(x, y, 0, _PFG_R8_UNORM).r), bytePixel(x, y));
            _test.assertEqual(readPixel(srgbBox, x, y), (bytePixel(x, y) << 24) | 0xFF);
        }
    }
    ::floatTicket.unmap();
    ::singleTicket.unmap();
    ::srgbTicket.unmap();

    _test.endTest();
}
