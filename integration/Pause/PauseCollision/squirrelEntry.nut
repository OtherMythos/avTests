//A test to check that collision worlds can be paused correctly.

function functionCallback(id, eventType){
    _test.assertEqual(id, 1);
    switch(eventType){
        case _COLLISION_INSIDE:
            print("inside")
            ::insideCount++;
            break;
        case _COLLISION_ENTER:
            print("enter")
            ::enterCount++;
            break;
        case _COLLISION_LEAVE:
            print("leave")
            ::leaveCount++;
            break;
    }
}

function start(){
    ::stage <- 0;
    ::stageCount <- 0;
    ::insideCount <- 0;
    ::enterCount <- 0;
    ::leaveCount <- 0;
    _world.createWorld();

    local initialTable = {
        "func" : functionCallback,
        "id" : 1,
        "type" : _COLLISION_PLAYER,
        "event" : _COLLISION_INSIDE | _COLLISION_ENTER | _COLLISION_LEAVE
    };
    local receiverInfo = {
        "type" : _COLLISION_PLAYER,
    };

    local cubeShape = _physics.getCubeShape(1, 1, 1);

    ::sender <- _physics.collision[0].createSender(initialTable, cubeShape);
    ::receiver <- _physics.collision[0].createReceiver(receiverInfo, cubeShape);

}

function update(){
    if(stage == 0){
        _physics.collision[0].addObject(::sender);
        _physics.collision[0].addObject(::receiver);
        stage++;
    }else if(stage == 1){
        _test.assertEqual(::insideCount, 1);
        _test.assertEqual(::enterCount, 1);
        _state.setPauseState(_PAUSE_PHYSICS);
        //Set the position so that they no longer intersect.
        //::sender.setPosition(20, 20, 20);
        stage++;
    }else if(stage == 2){
        _test.assertEqual(::insideCount, 1);
        _test.assertEqual(::enterCount, 1);

        ::stageCount++;
        if(stageCount >= 20){ //Nothing should change while paused.
            stage++;
            stageCount = 0;
            _state.setPauseState(_PAUSE_PHYSICS | _PAUSE_PHYSICS_COLLISION);
        }
    }else if(stage == 3){
        _test.assertEqual(::insideCount, 1);
        _test.assertEqual(::enterCount, 1);

        ::stageCount++;
        if(stageCount >= 20){
            _state.setPauseState(_PAUSE_PHYSICS_COLLISION);
            stage++;
            stageCount = 0;
        }
    }else if(stage == 4){
        _test.assertEqual(::insideCount, 1);
        _test.assertEqual(::enterCount, 1);

        ::stageCount++;
        if(stageCount >= 20){
            _state.setPauseState(0);
            stage++;
            stageCount = 1;
        }
    }else if(stage == 5){
        _test.assertEqual(::insideCount, stageCount);
        _test.assertEqual(::enterCount, 1);
        ::stageCount++;

        if(stageCount > 50){
            stage++;
            stageCount = 0;
            //Check that if I move them I get the expected leave count increase.
            ::sender.setPosition(-10, 0, 0);
            ::sender.setPosition(10, 0, 0);
        }
    }else if(stage == 6){
        _test.assertTrue(::insideCount > 0);
        _test.assertTrue(::enterCount > 0);
        _test.endTest();
    }
}
