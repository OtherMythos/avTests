//This test creates a physics object, lets it fall, then pauses the world, checking the object stops appropriately.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 200);
    _camera.lookAt(0, 0, 0);

    ::stageCount <- 0;
    ::stage <- 0;

    ::en <- _entity.create(SlotPosition());

    local shape = _physics.getCubeShape(1, 1, 1);
    ::body <- _physics.dynamics.createRigidBody(shape);


    //Create an entity and give it this body.
    _component.rigidBody.add(en, body);
    _component.mesh.add(en, "ogrehead2.mesh");
}

function update(){
    if(stage == 0){
        //Stage count counts how many times each stage happened.
        stageCount++;
        //Should start off at 50.
        _test.assertEqual(en.getPosition(), SlotPosition());

        if(stageCount >= 10) {
            stageCount = 0;
            stage++;
        }
    }
    if(stage == 1){
        //Now add the body.
        _physics.dynamics.addBody(body);

        stage++;
    }
    if(stage == 2){
        //The shape should now start falling.

        local pos = en.getPosition();
        print(pos.y);
        if(pos.y <= -50){
            //Make a note of this position.
            ::firstPos <- pos;
            //_physics.dynamics.removeBody(body);
            _state.setPauseState(_PAUSE_PHYSICS);
            stage++;
            stageCount = 0;
        }
    }
    if(stage == 3){
        _test.assertEqual(en.getPosition(), ::firstPos);
        stageCount++;
        if(stageCount >= 50){
            _state.setPauseState(0);
            stageCount = 0;
            //Set both, they should both pause the operation of the dynamics simulation.
            _state.setPauseState(_PAUSE_PHYSICS | _PAUSE_PHYSICS_DYNAMICS);
            stage++;
        }
    }
    if(stage == 4){
        _test.assertEqual(en.getPosition(), ::firstPos);
        stageCount++;
        if(stageCount >= 50){
            //Just the one now.
            _state.setPauseState(_PAUSE_PHYSICS_DYNAMICS);
            stageCount = 0;
            stage++;
        }
    }
    if(stage == 5){
        _test.assertEqual(en.getPosition(), ::firstPos);
        stageCount++;
        if(stageCount >= 50){
            //Remove all pause states.
            _state.setPauseState(0);
            stageCount = 0;
            stage++;
        }
    }
    if(stage == 6){
        //Should continue moving.
        local pos = en.getPosition();
        print(pos.y);
        if(pos.y <= -100){
            _test.endTest();
        }
    }

}
