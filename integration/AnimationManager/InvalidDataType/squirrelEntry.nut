//A test to check that animations adhere to the data types set during data construction.

function start(){

    local firstNode = _scene.getRootSceneNode().createChildSceneNode();
    local secondNode = _scene.getRootSceneNode().createChildSceneNode();

    local datablock = _hlms.pbs.createDatablock("someDatablockName");

    _animation.loadAnimationFile("res://../../../Resources/Animations/AnimationDataAnimations.xml");

    { //Too few nodes.
        local failed = false;
        try{
            local animationInfo = _animation.createAnimationInfo([firstNode]);
            local currentAnim = _animation.createAnimation("first", animationInfo);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }
    { //Too many nodes.
        local failed = false;
        try{
            local animationInfo = _animation.createAnimationInfo([firstNode, secondNode, firstNode]);
            local currentAnim = _animation.createAnimation("first", animationInfo);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }
    { //Incorrect types.
        local failed = false;
        try{
            local animationInfo = _animation.createAnimationInfo([secondNode, datablock]);
            local currentAnim = _animation.createAnimation("first", animationInfo);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }
    { //Correct types. Should work.
        local failed = false;
        try{
            local animationInfo = _animation.createAnimationInfo([firstNode, secondNode]);
            local currentAnim = _animation.createAnimation("first", animationInfo);
        }catch(e){
            failed = true;
        }
        _test.assertFalse(failed);
    }

    { //Different animation, three values this time.
        local failed = false;
        try{
            local animationInfo = _animation.createAnimationInfo([secondNode, datablock, secondNode]);
            local currentAnim = _animation.createAnimation("second", animationInfo);
        }catch(e){
            failed = true;
        }
        _test.assertFalse(failed);
    }
    { //Incorrect values.
        local failed = false;
        try{
            local animationInfo = _animation.createAnimationInfo([secondNode, firstNode, secondNode]);
            local currentAnim = _animation.createAnimation("second", animationInfo);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }
    { //Incorrect values.
        local failed = false;
        try{
            local animationInfo = _animation.createAnimationInfo([secondNode, firstNode, secondNode]);
            local currentAnim = _animation.createAnimation("second", animationInfo);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }
    { //Not enough values.
        local failed = false;
        try{
            local animationInfo = _animation.createAnimationInfo([secondNode]);
            local currentAnim = _animation.createAnimation("second", animationInfo);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    _test.endTest();
}

function update(){

}
