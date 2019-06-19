function start(){
    
}

function update(){
    ::first <- _physics.getCubeShape(10, 20, 30);
    //0 means cube. 1 means sphere. It's just the enum in the PhysicsShapeManager.
    _test.assertTrue(_test.physics.getShapeExists(0, 10, 20, 30));

    //Destroy first.
    delete ::first
    _test.assertFalse(_test.physics.getShapeExists(0, 10, 20, 30));


    //Now re-create a shape with those values, but with a different variable name.
    ::another <- _physics.getCubeShape(10, 20, 30);
    _test.assertTrue(_test.physics.getShapeExists(0, 10, 20, 30));
    delete ::another;
    _test.assertFalse(_test.physics.getShapeExists(0, 10, 20, 30));



    //Re-create the variable another.
    ::another <- _physics.getCubeShape(35, 45, 55);
    _test.assertTrue(_test.physics.getShapeExists(0, 35, 45, 55));

    //Give the shape to another instance.
    ::second <- ::another;

    //Destroy the first shape. It should still exist as long as second still exists.
    delete ::another;
    _test.assertTrue(_test.physics.getShapeExists(0, 35, 45, 55));

    //Now destroy second and check the shape was destroyed.
    delete ::second;
    _test.assertFalse(_test.physics.getShapeExists(0, 35, 45, 55));



    //Create a sphere
    ::firstSphere <- _physics.getSphereShape(10);
    _test.assertTrue(_test.physics.getShapeExists(1, 10, 0, 0));

    ::secondSphere <- _physics.getSphereShape(20);
    _test.assertTrue(_test.physics.getShapeExists(1, 20, 0, 0));

    //Override this shape with a different one.
    ::secondSphere <- _physics.getSphereShape(30);
    _test.assertFalse(_test.physics.getShapeExists(1, 20, 0, 0));
    _test.assertTrue(_test.physics.getShapeExists(1, 30, 0, 0));

    delete ::firstSphere
    delete ::secondSphere



    //Similar but with spheres this time.
    ::another <- _physics.getSphereShape(10);
    _test.assertTrue(_test.physics.getShapeExists(1, 10, 0, 0));

    //Give the shape to another instance.
    ::second <- another;

    //Destroy the first shape. It should still exist as long as second still exists.
    delete ::another;
    _test.assertTrue(_test.physics.getShapeExists(1, 10, 0, 0));

    //Now destroy second and check the shape was destoyed.
    delete ::second;
    _test.assertFalse(_test.physics.getShapeExists(1, 10, 0, 0));


    _test.endTest();
}
