//A test which checks safe raycast steps.

function start(){

    ::stage <- 0;

    local firstItem = _scene.createItem("cube");
    local secondItem = _scene.createItem("cube");

    firstItem.setQueryFlags(1 << 6);
    secondItem.setQueryFlags(1 << 5);

    ::firstNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::firstNode.setPosition(Vec3(0, 0, 10));
    firstNode.attachObject(firstItem);

    ::secondNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::secondNode.setPosition(Vec3(0, 0, -10));
    secondNode.attachObject(secondItem);

    _camera.setPosition(0, 0, -30);
    _camera.lookAt(0, 0, 0);


    //_test.endTest();
}

function sceneSafeUpdate(){
    local failed = false;
    try{
        firstNode.setPosition(Vec3(1, 1, 1));
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    print("safe update");
}

function update(){
    //firstNode.setPosition(Vec3(1, 1, 1));
    local createdRay = _camera.getCameraToViewportRay(0.5, 0.5);

    local failed = false;
    try{
        //Casting when the scene is unsafe should throw an error.
        _scene.testRayForSlot(createdRay);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    print("unsafe update");
}
