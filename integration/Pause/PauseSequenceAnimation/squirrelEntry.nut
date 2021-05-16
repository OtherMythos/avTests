//A test to check that sequence animations can be paused.

function start(){
    ::stage <- 0;
    ::stageCount <- 0;
    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);
    ::rootNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::previousPos <- Vec3(-10, -10, 0);
    rootNode.attachObject(_scene.createItem("cube"));

    _animation.loadAnimationFile("res://../../../Resources/Animations/GeneralAnimations.xml");

    ::animationInfo <- _animation.createAnimationInfo([rootNode]);
    ::currentAnim <- _animation.createAnimation("animPos", animationInfo);
}

function update(){
    print(stage);
    if(stage == 0){
        local pos = rootNode.getPositionVec3();
        print(pos);
        _test.assertTrue(pos.x >= previousPos.x);
        _test.assertTrue(pos.y >= previousPos.y);
        previousPos = pos;
        _test.assertEqual(_animation.getNumActiveAnimations(), 1);
        if(pos.x == 10 && pos.y == 10){
            _state.setPauseState(_PAUSE_ANIMATIONS);
            stage++;
        }
    }
    else if(stage == 1){
        stageCount++;
        _test.assertEqual(_animation.getNumActiveAnimations(), 1);
        local pos = rootNode.getPositionVec3();
        _test.assertTrue(pos.x == 10 && pos.y == 10);
        if(stageCount >= 50){
            _state.setPauseState(0);
            stage++;
        }
    }
    else if(stage == 2){
        local pos = rootNode.getPositionVec3();
        print(pos);
        _test.assertTrue(pos.x <= previousPos.x);
        _test.assertTrue(pos.y <= previousPos.y);
        previousPos = pos;
        _test.assertEqual(_animation.getNumActiveAnimations(), 1);
        if(pos.x == 0.125 && pos.y == 0.125){
            _test.endTest();
        }
    }
}
