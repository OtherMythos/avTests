//A test to check the camera creation and node attaching api.
//Just do a few things with the camera and ensure the engine doesn't crash.

function start(){
    local node = _scene.getRootSceneNode().createChildSceneNode();

    local camera = _scene.createCamera("first");

    //Should conflict and no camera should be created.
    local failed = false;
    try{
        camera = _scene.createCamera("first");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    node.attachObject(camera);
    node.setPosition(100, 0, 100);
}

function update(){

    _test.endTest();
}
