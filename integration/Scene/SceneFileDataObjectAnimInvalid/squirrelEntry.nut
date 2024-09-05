//Parse a scene file as a re-useable object and get an animation data object from it, with some broken files to test.

function start(){

    local parentNode = _scene.getRootSceneNode().createChildSceneNode();
    _animation.loadAnimationFile("res://res/MultiTrackAnimation.xml");

    //The first should fail because it's higher than the engine's allowed max anim entries.
    local failed = false;
    local parsedData = null;
    try{
        parsedData = _scene.parseSceneFile("res://res/sceneInvalidIdx.avscene");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);
    _test.assertEqual(parsedData, null);

    //The second should fail because it references an animation which is not present in the list.
    parsedData = _scene.parseSceneFile("res://res/sceneValidAnimIdx.avscene");
    local animData = _scene.insertParsedSceneFileGetAnimInfo(parsedData);
    _test.assertNotEqual(parsedData, null);
    failed = false;
    try{
        //The animation only defines two animable nodes, whereas the scene defines three.
        mCurrentWorldAnim_ = _animation.createAnimation("animMultiPos", animData);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    _test.endTest();
}
