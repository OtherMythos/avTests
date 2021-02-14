//A test to check that animations can be created according to a definition.

function start(){
    //::mesh <- _mesh.create("cube");

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
        if(pos.x == 10 && pos.y == 10) stage++;
    }
    else if(stage == 1){
        local pos = rootNode.getPositionVec3();
        print(pos);
        _test.assertTrue(pos.x <= previousPos.x);
        _test.assertTrue(pos.y <= previousPos.y);
        previousPos = pos;
        _test.assertEqual(_animation.getNumActiveAnimations(), 1);
        if(pos.x == 0.125 && pos.y == 0.125) stage++;
    }
    else if(stage == 2){
        stageCount++;
        _test.assertFalse(::currentAnim.isRunning());
        if(stageCount >= 20){
            //Check it doesn't move after.
            stageCount = 0;
            stage++;
            ::currentAnim = _animation.createAnimation("animScale", animationInfo);
        }
    }
    else if(stage == 3){
        local scale = rootNode.getScale();
        _test.assertTrue(scale.x >= previousPos.x);
        _test.assertTrue(scale.y >= previousPos.y);
        previousPos = scale;
        _test.assertEqual(_animation.getNumActiveAnimations(), 1);
        if(scale.x == 10 && scale.y == 10 && scale.z == 10) stage++;
    }
    else if(stage == 4){
        local scale = rootNode.getScale();
        _test.assertTrue(scale.x <= previousPos.x);
        _test.assertTrue(scale.y <= previousPos.y);
        previousPos = scale;
        _test.assertEqual(_animation.getNumActiveAnimations(), 1);
        if(scale.x <= 1.2 && scale.y <= 1.2 && scale.z <= 1.2) stage++;
    }
    else if(stage == 5){
        stageCount++;
        _test.assertFalse(::currentAnim.isRunning());
        if(stageCount >= 20){
            stageCount = 0;
            stage++;
            ::currentAnim = _animation.createAnimation("animOrientate", animationInfo);
        }
    }
    else if(stage == 6){
        if(_animation.getNumActiveAnimations() == 0){
            _test.endTest();
        }
    }
}
