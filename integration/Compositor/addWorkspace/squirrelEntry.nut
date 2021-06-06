//A test to check that a pre-defined workspace can be added to a scene.
//Really, just check the engine doesn't crash after 5 seconds.

function start(){

    local camera = _scene.createCamera("first");

    local renderTexture = _window.getRenderTexture();
    print(renderTexture.getWidth());
    _compositor.addWorkspace([renderTexture], camera, "testWorkspace", true);
}

function update(){

}
