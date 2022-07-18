//Parse a scene file as a re-useable object.

function start(){

    local parentNode = _scene.getRootSceneNode().createChildSceneNode();

    local data = _scene.parseSceneFile("res://res/sceneData.avscene");
    _scene.insertParsedSceneFile(data, parentNode);

    _test.assertEqual(parentNode.getNumChildren(), 1);
    local checkChild = parentNode.getChild(0);
    //Should be no attached objects as it's an empty.
    _test.assertEqual(checkChild.getNumAttachedObjects(), 0);
    _test.assertEqual(checkChild.getNumChildren(), 5);

    local expectedChildren = [0, 0, 0, 0, 1];
    foreach(c,i in expectedChildren){
        print(c);
        _test.assertEqual(checkChild.getChild(c).getNumChildren(), i);
    }

    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);

    //Check for broken files
    {
        local values = [
            function(){
                _scene.insertSceneFile("res://res/sceneDataBroken.avscene");
            },
            function(){
                _scene.insertSceneFile("res://res/sceneDataMeshBrokenPos.avscene");
            },
            function(){
                _scene.insertSceneFile("res://res/sceneDataMeshBrokenScale.avscene");
            },
        ];
        foreach(c,i in values){
            print(c);
            local failed = false;
            try{
                i();
            }catch(e){
                print(e);
                failed = true;
            }
            _test.assertTrue(failed);
        }
    }

    _test.endTest();
}
