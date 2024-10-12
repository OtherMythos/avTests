//A test to check lottie animations work as expected.

function start(){

    const TEXT_WIDTH = 800;
    const TEXT_HEIGHT = 800;

    ::currentFrame <- 0;
    ::runs <- 0;

    ::anim <- _lottie.createAnimation("res://../../../Resources/lottie/bell.json");
    print(anim);

    ::surface <- _lottie.createSurface(TEXT_WIDTH, TEXT_HEIGHT);
    print(surface);

    //Ensure it has the right number of frames relative to the file.
    _test.assertEqual(43, anim.totalFrame());

    ::texture <- _graphics.createTexture("lottieTexture");
    texture.setResolution(TEXT_WIDTH, TEXT_HEIGHT);
    texture.setPixelFormat(_PFG_RGBA8_UNORM);
    texture.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);

    ::stagingTexture <- _graphics.getStagingTexture(TEXT_WIDTH, TEXT_HEIGHT, 1, 1, _PFG_RGBA8_UNORM);

    local blendBlock = _hlms.getBlendblock({
        "dst_blend_factor": _HLMS_SBF_ONE_MINUS_SOURCE_ALPHA
    });
    local datablock = _hlms.unlit.createDatablock("textureDatablock", blendBlock);
    datablock.setTexture(0, texture);

    ::mesh <- _mesh.create("plane");
    mesh.setDatablock(datablock);

    _camera.setPosition(0, 0, 10);
    _camera.lookAt(0, 0, 0);
    _camera.setProjectionType(_PT_ORTHOGRAPHIC);
    _camera.setOrthoWindow(2, 2);
}

function update(){

    stagingTexture.startMapRegion();

    local textureBox = stagingTexture.mapRegion(TEXT_WIDTH, TEXT_HEIGHT, 1, 1, _PFG_RGBA8_UNORM);

    anim.renderSync(surface, ::currentFrame);

    surface.uploadToTextureBox(textureBox);

    stagingTexture.stopMapRegion();
    stagingTexture.upload(textureBox, texture, 0);


    ::currentFrame++;

    if(::currentFrame >= anim.totalFrame()){
        ::currentFrame = 0;
        ::runs++;

        if(runs >= 4){
            _test.endTest();
        }
    }
}