//A test to check the memory management of shapes and rigid bodies within the rigid body component.

function start(){
    _world.createWorld();
}

function update(){
    local en = _entity.create(SlotPosition());

    local shape = _physics.getCubeShape(1, 1, 1);
    local body = _physics.dynamics.createRigidBody(shape);

    //Create an entity and give it this body.
    _component.rigidBody.add(en, body);

    shape = body = 0;

    //Even though all scripted references to this shape have been removed, the shape should still exist as it's held by the entity component.
    _test.assertTrue(_test.physics.getShapeExists(0, 1, 1, 1));

    //If I now remove the component, both the shape and the body should be destroyed.
    _component.rigidBody.remove(en);
    _test.assertFalse(_test.physics.getShapeExists(0, 1, 1, 1));

    _test.endTest();
}
