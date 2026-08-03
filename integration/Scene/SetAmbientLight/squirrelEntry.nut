//A test which checks the api for ambient lights.

function start(){
    _scene.setAmbientLight(0xffffffff, 0xffffffff, Vec3(0, 1, 0));

    _scene.setAmbientLight(ColourValue(1, 0, 0, 1), ColourValue(0, 1, 0, 1), Vec3(0, 1, 0));

    local failed = false;
    try{
        //Incorrect type tag
        _scene.setAmbientLight(Vec3(), ColourValue(0, 1, 0, 1), Vec3(0, 1, 0));
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    _test.endTest();
}
