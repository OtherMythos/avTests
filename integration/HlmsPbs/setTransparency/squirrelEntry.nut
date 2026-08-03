//Checks objects can have their transparency altered.

//Render queue used for the refractive pass. See compositor/refractions.compositor.
::REFRACTIVE_QUEUE <- 50;
::OPAQUE_QUEUE <- 10;

function start(){
    ::stage <- 0;
    ::count <- 0.0;

    //The default compositor is disabled for this test, as refractions need the scene to be
    //rendered into a texture before the refractive objects can sample it.
    _compositor.addWorkspace([_window.getRenderTexture()], _camera.getCamera(), "RefractionsTestWorkspace", true);

    //Something opaque behind the transparent mesh, so there's actually content to refract.
    ::backdrop <- _mesh.create("ogrehead2.mesh");
    backdrop.setScale(0.1, 0.1, 0.1);
    backdrop.setPosition(0, 0, -20);
    backdrop.setRenderQueueGroup(OPAQUE_QUEUE);

    ::mesh <- _mesh.create("ogrehead2.mesh");
    mesh.setScale(0.1, 0.1, 0.1);
    mesh.setRenderQueueGroup(OPAQUE_QUEUE);
    _camera.setPosition(0, 0, 30);
    _camera.lookAt(0, 0, 0);

    ::datablock <- _hlms.pbs.createDatablock("someDatablockName");
    datablock.setTransparency(0.0);
    ::mesh.setDatablock(::datablock);

    local failed = false;
    try{
        //Test invalid mode
        datablock.setTransparency(count, 100);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);
}

function update(){
    count += 0.01;
    if(count >= 1.0){
        count = 0;
        stage++;

        if(stage == 2){
            //A refractive datablock may only be rendered by a pass which was set up with
            //use_refractions. Move the mesh into that pass before the mode is changed,
            //otherwise Ogre asserts.
            mesh.setRenderQueueGroup(REFRACTIVE_QUEUE);
        }
        else if(stage > 2){
            _test.endTest();
            return;
        }
    }

    if(stage == 0){
        datablock.setTransparency(count);
    }
    else if(stage == 1){
        //Try the different modes.
        datablock.setTransparency(count, _PBS_TRANSPARENCY_FADE);
    }
    else if(stage == 2){
        datablock.setTransparency(count, _PBS_TRANSPARENCY_REFRACTIVE);
    }
}
