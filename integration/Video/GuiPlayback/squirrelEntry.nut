enum PlaybackPhase{
    FIRST_FRAME
    PLAYING
    LAST_FRAME
    REWOUND
}

const SIZE = 64;

function setReadbackCanvas(){
    local size = Vec2(SIZE, SIZE);
    _gui.setCanvasSize(size, size);
}

function start(){
    ::video <- _video.open("res://red-blue.mpg");
    ::videoTexture <- ::video.getTexture();
    _test.assertTrue(::videoTexture.isValid());
    _test.assertEqual(::videoTexture.getWidth(), 35);
    _test.assertEqual(::videoTexture.getHeight(), 19);
    _test.assertEqual(::video.getFrameRate(), 25.0);
    _test.assertFalse(::video.advance(0));

    ::material <- _hlms.unlit.createDatablock("videoPanel");
    ::material.setTexture(0, ::videoTexture);

    //The GUI pass draws into the fixed readback target even when the window resizes.
    setReadbackCanvas();
    _event.subscribe(_EVENT_SYSTEM_WINDOW_RESIZE, function(id, data){
        setReadbackCanvas();
    }, this);

    ::window <- _gui.createWindow();
    ::window.setSize(SIZE, SIZE);
    ::window.setVisualsEnabled(false);
    local panel = ::window.createPanel();
    panel.setPosition(12, 20);
    panel.setSize(40, 24);
    panel.setDatablock(::material);

    //Render the GUI once into a readable texture, then present it to the window.
    ::target <- _graphics.createTexture("videoPanelReadback");
    ::target.setResolution(SIZE, SIZE);
    ::target.setPixelFormat(_PFG_RGBA8_UNORM);
    ::target.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);
    ::workspace <- _compositor.addWorkspace([::target, _window.getRenderTexture()],
        _camera.getCamera(), "VideoGuiPlaybackWorkspace", true);
    ::ticket <- _graphics.createAsyncTextureTicket(SIZE, SIZE, _PFG_RGBA8_UNORM);

    ::phase <- PlaybackPhase.FIRST_FRAME;
    ::readbackPending <- false;
}

function update(dt){
    if(::phase == PlaybackPhase.PLAYING){
        ::video.advance(dt);
        if(::video.hasEnded()){
            _test.assertFalse(::video.advance(dt));
            ::phase = PlaybackPhase.LAST_FRAME;
        }
        return;
    }

    if(!::readbackPending){
        ::ticket.download(::target, 0, true);
        ::readbackPending = true;
        return;
    }
    if(!::ticket.queryIsTransferDone()) return;

    local pixels = ::ticket.map(0);
    local centre = pixels.getColourAt(SIZE / 2, SIZE / 2, 0, _PFG_RGBA8_UNORM);
    local corner = pixels.getColourAt(0, 0, 0, _PFG_RGBA8_UNORM);
    ::ticket.unmap();
    ::readbackPending = false;

    //A download can capture the previous render while the new frame is pending.
    if(corner.r < 0.9 || corner.g > 0.1 || corner.b < 0.9) return;
    local red = centre.r > 0.9 && centre.g < 0.1 && centre.b < 0.1;
    local blue = centre.r < 0.1 && centre.g < 0.1 && centre.b > 0.9;
    if(::phase == PlaybackPhase.FIRST_FRAME && red){
        ::phase = PlaybackPhase.PLAYING;
    }else if(::phase == PlaybackPhase.LAST_FRAME && blue){
        ::video.rewind();
        _test.assertFalse(::video.hasEnded());
        _test.assertTrue(::videoTexture.isValid());
        ::phase = PlaybackPhase.REWOUND;
    }else if(::phase == PlaybackPhase.REWOUND && red){
        _gui.destroy(::window);
        _hlms.destroyDatablock(::material);
        ::video = null;
        _test.assertFalse(::videoTexture.isValid());
        _compositor.removeWorkspace(::workspace);
        _graphics.destroyTexture(::target);
        _test.endTest();
    }
}
