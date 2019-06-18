//This test creates two entities with rigid bodies with different masses.
//The body with the higher mass should fall quicker.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    local shape = _physics.getCubeShape(1, 1, 1);

    ::enFirst <- _entity.create(SlotPosition());
    ::enSecond <- _entity.create(SlotPosition());


    //One shape is created with 0 mass, so should not move.
    local firstInfo = {"mass": 20, "origin": [-30, 0, 0]};
    local secondInfo = {"mass": 0, "origin": [30, 0, 0]};
    local bodyFirst = _physics.dynamics.createRigidBody(shape, firstInfo);
    local bodySecond = _physics.dynamics.createRigidBody(shape, secondInfo);
    _test.assertNotEqual(bodyFirst, bodySecond);

    _physics.dynamics.addBody(bodyFirst);
    _physics.dynamics.addBody(bodySecond);

    _component.rigidBody.add(enFirst, bodyFirst);
    _component.rigidBody.add(enSecond, bodySecond);
    _component.mesh.add(enFirst, "ogrehead2.mesh");
    _component.mesh.add(enSecond, "ogrehead2.mesh");
}

function update(){
    local posFirst = enFirst.getPosition();
    local posSecond = enSecond.getPosition();

    //Only this one should reach -100.
    if(posFirst.y < -100){
        _test.endTest();
    }
    if(posSecond.y < -100){
        _test.endTest(false);
    }
}
