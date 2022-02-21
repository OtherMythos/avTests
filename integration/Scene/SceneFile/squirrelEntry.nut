//A test which checks scene files can be loaded by the engine and inserted into the scene.

function start(){
    ::count <- 0.0;
    _scene.insertSceneFile("res://res/sceneData.avscene");

    local values = [
        function(){
            _scene.insertSceneFile("res://res/sceneDataBroken.avscene");
        },
        function(){
            _scene.insertSceneFile("res://res/sceneDataMeshMissingPos.avscene");
        },
        function(){
            _scene.insertSceneFile("res://res/sceneDataMeshMissingScale.avscene");
        },
    ];

    //Broken
    foreach(i in values){
        local failed = false;
        try{
            i();
        }catch(e){
            print(e);
            failed = true;
        }
        _test.assertTrue(failed);
    }

    //::mesh <- _mesh.create("ogrehead2.mesh");
    _camera.setPosition(0, 0, 100);
    _camera.lookAt(0, 0, 0);

    //_test.endTest();
}

function update(){
    count += 0.1;
    _camera.setPosition(0, 0, count);
}
