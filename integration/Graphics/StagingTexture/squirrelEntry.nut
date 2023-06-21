//A test to check the basic lifecycle of a staging texture.

function start(){
    const TEXT_WIDTH = 100;
    const TEXT_HEIGHT = 100;

    local texture = _graphics.createTexture("testTexture");
    texture.setResolution(TEXT_WIDTH, TEXT_HEIGHT);
    texture.setPixelFormat(_PFG_RGBA8_UNORM);
    texture.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);

    local stagingTexture = _graphics.getStagingTexture(TEXT_WIDTH, TEXT_HEIGHT, 1, 1, _PFG_RGBA8_UNORM);

    stagingTexture.startMapRegion();

    local textureBox = stagingTexture.mapRegion(TEXT_WIDTH, TEXT_HEIGHT, 1, 1, _PFG_RGBA8_UNORM);

    //Write a gradient pattern.
    for(local y = 0; y < TEXT_HEIGHT; y++){
        local yVal = (y.tofloat() / TEXT_HEIGHT) * 0x80;
        for(local x = 0; x < TEXT_WIDTH; x++){
            local xVal = (x.tofloat() / TEXT_WIDTH) * 0x80;
            local v = xVal + yVal;
            textureBox.writen(v, 'b');
            textureBox.writen(v, 'b');
            textureBox.writen(v, 'b');
            textureBox.writen(0xFF, 'b');
        }
    }

    //Seek to the middle of the pattern and write a single line of black.
    local targetPos = (TEXT_WIDTH / 2) * TEXT_HEIGHT * 4;
    textureBox.seek(targetPos);
    for(local x = 0; x < TEXT_WIDTH; x++){
        textureBox.writen(0, 'b');
        textureBox.writen(0, 'b');
        textureBox.writen(0, 'b');
        textureBox.writen(0xFF, 'b');
    }

    _test.assertEqual(textureBox.tell(), targetPos + TEXT_WIDTH * 4);

    stagingTexture.stopMapRegion();
    stagingTexture.upload(textureBox, texture, 0);

    {
        local datablock = _hlms.unlit.createDatablock("testDatablock");
        datablock.setTexture(0, texture);

        ::mesh <- _mesh.create("plane");
        mesh.setDatablock(datablock);
        mesh.setPosition(0, 0, 0);
        local spacing = 0.2;
        mesh.setScale(spacing, spacing, spacing);
    }

    _camera.setPosition(0, 0, 10);
    _camera.lookAt(0, 0, 0);
    _camera.setProjectionType(_PT_ORTHOGRAPHIC);
    _camera.setOrthoWindow(2, 2);
}

function update(){

}