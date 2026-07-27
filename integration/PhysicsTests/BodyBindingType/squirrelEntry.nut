//A test to check the returned binding type of a rigid body.

function start(){
}

function update(){
    local en = _entity.create(Vec3());

    local body = _physics.dynamics.createRigidBody(_physics.getCubeShape(1, 1, 1));

    _test.assertEqual(0, body.boundType());

    _component.rigidBody.add(en, body);

    //Entity type has an id of 1.
    _test.assertEqual(1, body.boundType());

    _component.rigidBody.remove(en);
    _test.assertEqual(0, body.boundType());

    _test.endTest();
}
