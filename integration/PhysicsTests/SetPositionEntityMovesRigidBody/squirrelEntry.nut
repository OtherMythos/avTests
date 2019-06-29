//A test to check that setting an entity position also moves the attached rigid body.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 100);
    _camera.lookAt(0, 0, 0);

    ::stage <- 0;
    ::stageCount <- 0;

    ::en <- _entity.create(SlotPosition());
    local shape = _physics.getCubeShape(1, 1, 1);
    local body = _physics.dynamics.createRigidBody(shape);
    _component.rigidBody.add(en, body);
    _component.mesh.add(en, "ogrehead2.mesh");

    _physics.dynamics.addBody(body);
}

function update(){

    if(stage == 0){
        if(en.getPosition().y < -100){
            //Back to the origin
            en.setPosition(SlotPosition());
            _test.assertEqual(en.getPosition(), SlotPosition());

            stage++;
        }
    }
    if(stage == 1){
        stageCount++;

        //The rigid body should have moved with the entity
        if(en.getPosition().y < -100){
            _test.endTest(false);
        }
        //Check that it doesn't revert back to any stale data, and just starts falling from where it was positioned.
        if(stageCount >= 20){
            _test.endTest();
        }
    }
}
