//Check animations can be stored in animation components.

function start(){
    _world.createWorld();

    ::stage <- 0;
    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);

    ::timeCounter <- 0;
    ::previousPos <- Vec3(-10, -10, 0);
    ::rootNode <- _scene.getRootSceneNode().createChildSceneNode();
    rootNode.attachObject(_scene.createItem("cube"));

    _animation.loadAnimationFile("res://../../../Resources/Animations/GeneralAnimations.xml");

    local animationInfo = _animation.createAnimationInfo([rootNode]);
    local firstAnim = _animation.createAnimation("animPos", animationInfo);

    ::e <- _entity.create(SlotPosition());
    _component.animation.add(e, firstAnim);
}

function update(){
    ::timeCounter++;
    for(local i = 0; i < 2; i++){
        //Check I can obtain the animation.
        local anim = _component.animation.get(::e, i);
        _test.assertEqual(anim.getTime(), timeCounter);
    }

    if(stage == 0){
        local pos = rootNode.getPositionVec3();
        _test.assertTrue(pos.x >= previousPos.x);
        _test.assertTrue(pos.y >= previousPos.y);
        previousPos = pos;
        if(pos.x == 10 && pos.y == 10) {
            stage++;
        }
    }
    else if(stage == 1){
        local pos = rootNode.getPositionVec3();
        _test.assertTrue(pos.x <= previousPos.x);
        _test.assertTrue(pos.y <= previousPos.y);
        previousPos = pos;
        //TODO This should reach 0 eventually.
        if(pos.x == 0.125 && pos.y == 0.125) stage++;
    }
    else if(stage == 2){
        _test.endTest();
    }
}
