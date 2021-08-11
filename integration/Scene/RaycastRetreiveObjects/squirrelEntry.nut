//A test which checks raycasts can retreive correct objects.

function start(){

    local firstItem = _scene.createItem("cube");
    local secondItem = _scene.createItem("cube");

    ::firstNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::firstNode.setPosition(Vec3(0, 0, 10));
    firstNode.attachObject(firstItem);

    ::secondNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::secondNode.setPosition(Vec3(0, 0, -10));
    secondNode.attachObject(secondItem);

    _camera.setPosition(0, 0, -30);
    _camera.lookAt(0, 0, 0);

    ::createdRay <- _camera.getCameraToViewportRay(0.5, 0.5);
    print(::createdRay.getOrigin());

    //Reposition the camera to make things more obvious.
    _camera.setPosition(0, 30, -30);
    _camera.lookAt(0, 0, 0);
}

function sceneSafeUpdate(){

    {
        local foundObject = _scene.testRayForObject(::createdRay);
        _test.assertNotEqual(null, foundObject);
        local foundPos = foundObject.getParentNode().getPositionVec3();
        //Check the position is correct implying that it returned the correct object.
        _test.assertEqual(foundPos.x, 0);
        _test.assertEqual(foundPos.y, 0);
        _test.assertEqual(foundPos.z, -10);
    }

    {
        local foundObjects = _scene.testRayForObjectArray(::createdRay);
        _test.assertNotEqual(null, foundObjects);
        _test.assertEqual(foundObjects.len(), 2);
        //Should find both of the objects.
        local firstFound = false;
        local secondFound = false;
        foreach(i in foundObjects){
            local objPos = i.getParentNode().getPositionVec3();

            _test.assertEqual(objPos.x, 0);
            _test.assertEqual(objPos.y, 0);

            if(objPos.z == -10){
                _test.assertFalse(firstFound);
                firstFound = true;
            }
            else if(objPos.z == 10){
                _test.assertFalse(secondFound);
                secondFound = true;
            }
        }
        _test.assertTrue(firstFound);
        _test.assertTrue(secondFound);
    }


    _test.endTest();

}
