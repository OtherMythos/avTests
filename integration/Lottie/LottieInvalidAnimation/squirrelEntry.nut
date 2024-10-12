//A test to check lottie animations work as expected.

function start(){

    const TEXT_WIDTH = 800;
    const TEXT_HEIGHT = 800;

    local failed = false;
    try{
        local anim = _lottie.createAnimation("invalidAnim");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    failed = false;
    try{
        local anim = _lottie.createAnimation("res://../../../Resources/lottie/brokenAnim.json");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    local workingAnim = _lottie.createAnimation("res://../../../Resources/lottie/bell.json");
    _test.assertNotEqual(workingAnim, null);

    local surface = _lottie.createSurface(20, 20);
    surface = null;
    print(surface);

    _test.endTest();
}
