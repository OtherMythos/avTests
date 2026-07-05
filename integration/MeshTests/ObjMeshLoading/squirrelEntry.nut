//A test to check that meshes can be loaded from obj files.
//As well as asserting the api behaves, this renders the loaded mesh for a few
//seconds so the result can be inspected visually.

//Number of frames to display the mesh before ending the test.
DISPLAY_FRAMES <- 300;

function start(){
    ::frameCount <- 0;

    //Light the scene so the mesh is visible, and frame it with the camera.
    _scene.setAmbientLight(ColourValue(0.6, 0.6, 0.6, 1.0), ColourValue(0.3, 0.3, 0.35, 1.0), Vec3(0, -1, 0));
    _camera.setPosition(3, 3, 5);
    _camera.lookAt(0, 0, 0);

    //Creating a mesh from an obj file should work anywhere a .mesh file would.
    ::objMesh <- _mesh.create("testCube.obj");

    //Items should be creatable through the scene as well.
    local item = _scene.createItem("testCube.obj");

    //A second request for the same obj should re-use the registered mesh.
    local secondMesh = _mesh.create("testCube.obj");
    secondMesh.setPosition(3, 0, 0);

    //The following two cases deliberately fail to load. Each logs an Ogre error
    //which is expected and caught here; it does not indicate a test failure.
    print("The next two Ogre errors are expected (negative test cases).");

    //An obj file which doesn't exist should throw an error.
    local failed = false;
    try{
        _mesh.create("meshThatDoesntExist.obj");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    //A malformed obj file should throw an error rather than crash.
    failed = false;
    try{
        _mesh.create("invalidMesh.obj");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);
}

function update(){
    //Slowly spin the mesh so it is clearly being rendered.
    objMesh.setOrientation(Quat(frameCount * 0.02, Vec3(0, 1, 0)));

    frameCount++;
    if(frameCount >= DISPLAY_FRAMES){
        _test.endTest();
    }
}
