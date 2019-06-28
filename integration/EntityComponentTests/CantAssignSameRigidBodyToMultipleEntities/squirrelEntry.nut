//A test to check that the same rigid body can't be assigned to multiple entities.

function start(){
    _world.createWorld();
}

function update(){
    local en1 = _entity.create(SlotPosition());
    local en2 = _entity.create(SlotPosition());

    local shape = _physics.getCubeShape(1, 1, 1);
    local body = _physics.dynamics.createRigidBody(shape);

    //Can't assign a mesh to an entity if it already has one.
    _test.assertTrue(_component.rigidBody.add(en1, body));

    _test.assertFalse(_component.rigidBody.add(en1, body));


    //Can't assign the same mesh to multiple entities
    _test.assertFalse(_component.rigidBody.add(en2, body));

    //If I now remove the mesh from the previous entity, it should be able to be attached.
    _component.rigidBody.remove(en1);
    _test.assertTrue(_component.rigidBody.add(en2, body));

    _test.endTest();
}
