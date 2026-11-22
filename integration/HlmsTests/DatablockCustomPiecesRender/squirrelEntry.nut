//Custom pieces change what a datablock draws. Five red unlit squares in a row:
//  0: no custom piece, stays red.
//  1: a piece file that writes green.
//  2: a piece file that writes blue only when the customPiecesBlue property is set, and it is.
//  3: the same piece file without the property, so it stays red.
//  4: the same as 2, but set up by a .material.json.

const SIZE = 64;
const RED = 0xFF0000FF;
const GREEN = 0x00FF00FF;
const BLUE = 0x0000FFFF;

function channelToByte(value){
    return (value * 255.0 + 0.5).tointeger();
}

function readPixel(box, x, y){
    local c = box.getColourAt(x, y, 0, _PFG_RGBA8_UNORM);
    return (channelToByte(c.r) << 24) | (channelToByte(c.g) << 16) | (channelToByte(c.b) << 8) | channelToByte(c.a);
}

//A square reaching 4 world units either side of x, one world unit to a pixel.
function createSquare(datablock, x){
    local mesh = _mesh.create("plane");
    mesh.setDatablock(datablock);
    mesh.setPosition(x, 0, 0);
    mesh.setScale(4, 4, 4);
    return mesh;
}

function createRedDatablock(name){
    local datablock = _hlms.unlit.createDatablock(name);
    datablock.setUseColour(true);
    datablock.setColour(1, 0, 0, 1);
    return datablock;
}

function start(){
    ::texture <- _graphics.createTexture("customPiecesRenderTarget");
    ::texture.setResolution(SIZE, SIZE);
    ::texture.setPixelFormat(_PFG_RGBA8_UNORM);
    ::texture.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);

    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);
    _camera.setProjectionType(_PT_ORTHOGRAPHIC);
    _camera.setOrthoWindow(SIZE, SIZE);
    ::workspace <- _compositor.addWorkspace([::texture], _camera.getCamera(), "CustomPiecesRender/workspace", true);

    local plain = createRedDatablock("customPiecesRenderPlain");

    local green = createRedDatablock("customPiecesRenderGreen");
    green.setCustomPieceFile("customPiecesRenderGreen.any", _HLMS_PIECE_STAGE_PS);

    local blue = createRedDatablock("customPiecesRenderBlue");
    blue.setCustomPieceFile("customPiecesRenderBlue.any", _HLMS_PIECE_STAGE_PS);
    blue.setCustomProperties({ customPiecesBlue = 1 });

    local gated = createRedDatablock("customPiecesRenderGated");
    gated.setCustomPieceFile("customPiecesRenderBlue.any", _HLMS_PIECE_STAGE_PS);

    local json = _hlms.getDatablock("customPiecesRenderJson");
    _test.assertTrue(json != null);
    _test.assertEqual("customPiecesRenderBlue.any", json.getCustomPieceFile(_HLMS_PIECE_STAGE_PS));
    _test.assertEqual(1, json.getCustomProperties()["customPiecesBlue"]);

    ::squares <- [
        createSquare(plain, -24),
        createSquare(green, -12),
        createSquare(blue, 0),
        createSquare(gated, 12),
        createSquare(json, 24)
    ];

    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);
    ::ticket.download(::texture, 0, true);
}

function update(){
    if(!::ticket.queryIsTransferDone()) return;

    local box = ::ticket.map(0);
    //Until the workspace first reaches it the texture holds whatever its memory did.
    if(readPixel(box, 8, 32) != RED){
        ::ticket.unmap();
        ::ticket.download(::texture, 0, true);
        return;
    }

    _test.assertEqual(RED, readPixel(box, 8, 32));
    _test.assertEqual(GREEN, readPixel(box, 20, 32));
    _test.assertEqual(BLUE, readPixel(box, 32, 32));
    _test.assertEqual(RED, readPixel(box, 44, 32));
    _test.assertEqual(BLUE, readPixel(box, 56, 32));
    //Between the squares is the clear colour.
    _test.assertEqual(0, readPixel(box, 14, 32));
    ::ticket.unmap();

    _test.endTest();
}
