//A test which checks scene files can be loaded by the engine and inserted into the scene.

function start(){
    //Should just execute without error
    _scene.insertSceneFile("res://res/sceneData.avscene");

    //Insert into a scene node.
    local targetNode = _scene.getRootSceneNode().createChildSceneNode();
    _scene.insertSceneFile("res://res/sceneData.avscene", targetNode);

    //Broken scene files.
    //I have to call them in a try catch as they throw errors.
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

    _camera.setPosition(0, 0, 100);
    _camera.lookAt(0, 0, 0);

    _test.endTest();
}
