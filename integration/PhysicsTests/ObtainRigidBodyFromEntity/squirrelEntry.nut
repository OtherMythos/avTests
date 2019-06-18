//This test creates a rigid body, assigns it to an entity, and then tries to re-obtain that body.

function start(){
    _world.createWorld();
}

function update(){
    local en = _entity.create(SlotPosition());
    _test.assertEqual(_component.rigidBody.get(en), null);

    local shape = _physics.getCubeShape(1, 1, 1);
    local originalBody = _physics.dynamics.createRigidBody(shape);

    _component.rigidBody.add(en, originalBody);


    local obtainedBody = _component.rigidBody.get(en);
    _test.assertEqual(obtainedBody, originalBody);

    //Now remove the body.
    _component.rigidBody.remove(en);
    obtainedBody = _component.rigidBody.get(en);
    _test.assertEqual(obtainedBody, null);

    _test.endTest();
}
