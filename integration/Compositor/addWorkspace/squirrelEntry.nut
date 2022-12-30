//A test to check that a pre-defined workspace can be added to a scene.
//Really, just check the engine doesn't crash after 5 seconds.

function start(){

    local camera = _scene.createCamera("first");
    local node = _scene.getRootSceneNode().createChildSceneNode();
    node.attachObject(camera);
    node.setPosition(0, 0, 30);
    camera.lookAt(0, 0, 0);

    _camera.setPosition(0, 0, 30);
    _camera.lookAt(0, 0, 0);

    ::mesh <- _mesh.create("ogrehead2.mesh");
    ::mesh.setScale(0.1, 0.1, 0.1);

    local renderTexture = _window.getRenderTexture();
    print(renderTexture.getWidth());
    _compositor.addWorkspace([renderTexture], camera, "testWorkspace", true);


    local failed = false;
    try{
        _compositor.addWorkspace([renderTexture], camera, "testWorkspace", true);
    }catch(e){
        failed = true;
    }

    _test.assertFalse(failed);
}

function update(){

}
