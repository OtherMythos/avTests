//A test to check that animations work when multiple tracks are used.

function start(){
    //::mesh <- _mesh.create("cube");

    ::stage <- 0;
    ::stageCount <- 0;
    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);
    ::firstNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::secondNode <- _scene.getRootSceneNode().createChildSceneNode();

    ::firstNodePrevPos <- Vec3(-10, -10, 0);
    ::secondNodePrevPos <- Vec3(10, 10, 0);
    firstNode.attachObject(_scene.createItem("cube"));
    secondNode.attachObject(_scene.createItem("cube"));

    _animation.loadAnimationFile("res://../../../Resources/Animations/MultiTrackAnimation.xml");

    ::animationInfo <- _animation.createAnimationInfo([firstNode, secondNode]);
    ::currentAnim <- _animation.createAnimation("animMultiPos", animationInfo);
}

function update(){
    print(stage);
    if(stage == 0){
        local pos = firstNode.getPositionVec3();
        _test.assertTrue(pos.x >= firstNodePrevPos.x);
        _test.assertTrue(pos.y >= firstNodePrevPos.y);

        local secondPos = secondNode.getPositionVec3();
        print(secondPos);
        _test.assertTrue(secondPos.x <= secondNodePrevPos.x);
        _test.assertTrue(secondPos.y <= secondNodePrevPos.y);

        firstNodePrevPos = pos;
        secondNodePrevPos = secondPos;
        print(pos);
        if(pos.x <= 0.5 && pos.y <= 0.5
        && secondPos.x <= 0.5 && secondPos.y <= 0.5){
            _test.endTest();
        }
    }
}
