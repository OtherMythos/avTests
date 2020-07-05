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
        ::expectedInsideCount <- insideCount;
        stage++;
    }else if(stage == 2){
        //Keep checking inside is called.
        _test.assertEqual(insideCount, expectedInsideCount);
        expectedInsideCount++;
        if(expectedInsideCount >= 30){
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
            ::expectedInsideCount = 0;
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
