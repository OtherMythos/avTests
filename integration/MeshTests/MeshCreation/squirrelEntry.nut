//A test to check that the namespace to create meshes works as expected.

function start(){

    //This mesh should load. If not it should throw an error and fail the test.
    local successMesh = _mesh.create("cube");

    local failed = false;
    try{
        local failMesh = _mesh.create("MeshThatDoesntExist");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    _test.endTest();
}
