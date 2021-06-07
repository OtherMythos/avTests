//A test to check that gpu textures can be created and destroyed properly.
//Engine owned textures cannot be deleted.

function start(){

    local renderTexture = _window.getRenderTexture();

    //Create a custom texture and check the functions can be used.
    //Should throw no errors.
    local newTex = _graphics.createTexture("testTexture");
    newTex.setResolution(500, 500);
    newTex.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);
    _test.assertTrue(newTex.isValid());

    //Destroy
    _graphics.destroyTexture(newTex);
    _test.assertFalse(newTex.isValid());

    //Re-create and check the functions still work.
    local secondNewTex = _graphics.createTexture("testTexture");
    secondNewTex.setResolution(500, 500);
    secondNewTex.scheduleTransitionTo(_GPU_RESIDENCY_RESIDENT);
    //Old handle should still be invalid.
    _test.assertFalse(newTex.isValid());
    _test.assertTrue(secondNewTex.isValid());

    local failed = false;
    try{
        //As this isn't createOrRetreive, it should throw an error if the texture already exists.
        local secondNewTexSameHandle = _graphics.createTexture("testTexture");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    //Getting an already existing texture.
    local secondNewTexSameHandle = _graphics.createOrRetreiveTexture("testTexture");
    _test.assertTrue(secondNewTexSameHandle.isValid());

    //Destroy one handle and both of them should be destroyed.
    _graphics.destroyTexture(secondNewTex);
    _test.assertFalse(secondNewTexSameHandle.isValid());
    _test.assertFalse(secondNewTex.isValid());

    //Create the texture again, checking it can be created fine.
    local thirdHandle = _graphics.createOrRetreiveTexture("testTexture");
    _test.assertTrue(thirdHandle.isValid());

    _test.endTest();
}

function update(){
}
