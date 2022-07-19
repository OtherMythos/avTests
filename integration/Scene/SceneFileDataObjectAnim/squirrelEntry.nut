//Parse a scene file as a re-useable object and get an animation data object from it, to then animate with.

function start(){

    local parentNode = _scene.getRootSceneNode().createChildSceneNode();

    local data = _scene.parseSceneFile("res://res/sceneData.avscene");
    local animData = _scene.insertParsedSceneFileGetAnimInfo(data, parentNode);

    ::firstNode <- parentNode.getChild(0).getChild(0);
    ::secondNode <- parentNode.getChild(0).getChild(1);

    _animation.loadAnimationFile("res://res/MultiTrackAnimation.xml");

    ::currentAnim <- _animation.createAnimation("animMultiPos", animData);

    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);

    ::prevPosFirst <- Vec2(-1, -1);
    ::prevPosSecond <- Vec2(-1, -1);
}

function update(){
    local newFirstPos = firstNode.getPositionVec3();
    local newSecondPos = secondNode.getPositionVec3();

    //Check the objects are moving.
    _test.assertNotEqual(prevPosFirst, newFirstPos);
    _test.assertNotEqual(prevPosSecond, newSecondPos);

    ::prevPosFirst = firstNode.getPositionVec3();
    ::prevPosSecond = secondNode.getPositionVec3();

    print(newSecondPos.x);
    //They've animated enough.
    if(newSecondPos.x <= 1.0){
        _test.endTest();
    }
}
