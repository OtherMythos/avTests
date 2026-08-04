//A test to check that collision objects can be added and removed from the world correctly.

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
        _test.assertEqual(enterCount, 1);
        _test.assertEqual(insideCount, 1);
        //insideCount + 1, because the physics step scheduled at the end of this update produces
        //another inside event which the next update drains. Physics advances exactly one step per
        //update, so the expected count and the real one stay in step from here.
        ::expectedInsideCount <- insideCount + 1;
        stage++;
    }else if(stage == 2){
        //Keep checking inside is called.
        _test.assertEqual(insideCount, expectedInsideCount);
        expectedInsideCount++;
        //Runs one update longer than >= would, so insideCount reaches the 30 stage 3 checks for.
        if(expectedInsideCount > 30){
            _physics.collision[0].removeObject(::sender);
            _physics.collision[0].removeObject(::receiver);
            ::stageCount <- 0;
            stage++;
        }
    }else if(stage == 3){
        stageCount++;
        _test.assertEqual(insideCount, 30);
        _test.assertEqual(enterCount, 1);
        if(stageCount >= 30){
            _test.assertEqual(leaveCount, 1);
            _physics.collision[0].addObject(::sender);
            _physics.collision[0].addObject(::receiver);
            //1 rather than 0 for the same reason as stage 1: the counters are zeroed here, then
            //the step scheduled at the end of this update produces one inside event before the
            //first stage 4 update gets to look.
            ::expectedInsideCount = 1;
            ::insideCount = 0;
            ::enterCount = 0;
            ::leaveCount = 0;
            stage++;
        }
    }else if(stage == 4){
        _test.assertEqual(insideCount, expectedInsideCount);
        expectedInsideCount++;
        if(expectedInsideCount >= 30){
            _test.assertEqual(enterCount, 1);
            _test.endTest();
        }
    }
}
