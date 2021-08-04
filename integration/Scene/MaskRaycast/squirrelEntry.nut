//A test which tests masked raycasts.
//In a masked raycast, only objects that match the mask flags are collided with.

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

function update(){

    if(stage == 0){
        //Defer the ray creation to make sure the window is the correct size.
        ::createdRay <- _camera.getCameraToViewportRay(0.5, 0.5);
        print(::createdRay.getOrigin());

        //Reposition the camera to make things more obvious.
        _camera.setPosition(0, 30, -30);
        _camera.lookAt(0, 0, 0);

        stage++;
    }
    else if(stage == 1){
        //As the mask is 0 nothing should be found, so should return null.
        local foundPos = _scene.testRayForSlot(::createdRay, 0);
        _test.assertEqual(null, foundPos);

        stage++;
    }
    else if(stage == 2){
        //Check all the objects.
        local foundPos = _scene.testRayForSlot(::createdRay, 0xFFFFFFFF);
        _test.assertNotEqual(null, foundPos);
        _test.assertTrue(foundPos.toVector3().z < 0);

        stage++;
    }
    else if(stage == 3){
        //Check the one furthest away from the camera.
        local foundPos = _scene.testRayForSlot(::createdRay, 1 << 6);
        _test.assertNotEqual(null, foundPos);

        _test.assertTrue(foundPos.toVector3().z > 0);

        stage++;
    }
    else if(stage == 4){
        _test.endTest();
    }

}
