//A test to check the memory management of shapes within rigid bodies.
//When a rigid body is created with a shape, the shape's reference will be incremented accordingly.
//This makes sure that the shape doesn't exist until everything using it is removed.

function start(){
    _world.createWorld();
}

function update(){
    local shape = _physics.getCubeShape(1, 1, 1);
    local body = _physics.dynamics.createRigidBody(shape);

    shape = 0;
    _test.assertTrue(_test.physics.getShapeExists(0, 1, 1, 1));
    body = 0;
    _test.assertFalse(_test.physics.getShapeExists(0, 1, 1, 1));

    //----

    shape = _physics.getCubeShape(10, 20, 30);
    _test.assertTrue(_test.physics.getShapeExists(0, 10, 20, 30));
    body = _physics.dynamics.createRigidBody(shape);
    shape = 0;
    //The shape should still exist, as it's reference has been incremented by the created rigid body.
    _test.assertTrue(_test.physics.getShapeExists(0, 10, 20, 30));
    body = 0;
    //Now it should be gone.
    _test.assertFalse(_test.physics.getShapeExists(0, 10, 20, 30));

    //----
    //Overriding one rigid body with another.
    local shape1 = _physics.getCubeShape(50, 20, 30);
    _test.assertTrue(_test.physics.getShapeExists(0, 50, 20, 30));
    local shape2 = _physics.getCubeShape(60, 20, 30);
    _test.assertTrue(_test.physics.getShapeExists(0, 60, 20, 30));
    local body1 = _physics.dynamics.createRigidBody(shape1);
    local body2 = _physics.dynamics.createRigidBody(shape2);
    //No more references to the shapes.
    shape1 = shape2 = 0;
    body1 = body2;
    //Body1 is now a duplicate of body2, and therefore shape1 should have been destroyed.
    _test.assertFalse(_test.physics.getShapeExists(0, 50, 20, 30));
    body2 = 0;
    _test.assertTrue(_test.physics.getShapeExists(0, 60, 20, 30));
    body1 = 0;
    _test.assertFalse(_test.physics.getShapeExists(0, 60, 20, 30));

    _test.endTest();
}
