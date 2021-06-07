//A test to check that squirrel functions can't edit the render window texture.

function start(){

    local renderTexture = _window.getRenderTexture();

    local failed = false;
    try{
        renderTexture.setResolution(300, 400);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    failed = false;
    try{
        renderTexture.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    //Create a custom texture and check the functions can be used.
    //Should throw no errors.
    local newTex = _graphics.createTexture("testTexture");
    newTex.setResolution(500, 500);
    newTex.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);

    _test.endTest();
}

function update(){

}
