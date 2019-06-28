//A test to check that a phyics shape can be obtained from a rigid body.

function start(){
    local shape = _physics.getCubeShape(1, 1, 1);


    local body = _physics.dynamics.createRigidBody(shape);

    local obtainedShape = body.getShape();

    _test.assertEqual(shape, obtainedShape);
    _test.assertTrue(_test.physics.getShapeExists(0, 1, 1, 1));

    //Destroy the original. The shape should still exist.
    shape = 0;
    _test.assertTrue(_test.physics.getShapeExists(0, 1, 1, 1));
    body = 0;
    _test.assertTrue(_test.physics.getShapeExists(0, 1, 1, 1));

    _test.endTest();
}

function update(){

}
