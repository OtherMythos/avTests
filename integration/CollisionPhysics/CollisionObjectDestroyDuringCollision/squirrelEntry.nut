//A test to check that objects can be destroyed during their own callbacks.

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
        if(insideCount >= 10) stage++;
    }else if(stage == 2){
        //Destroy the sender.
        ::sender = null;
        stage++;
    }else if(stage == 3){
        //Wait a bit for something to happen.
        stageCount++;
        if(stageCount >= 20){
            stage++;
        }
    }else if(stage == 4){
        _test.assertEqual(::enterCount, 1);
        _test.assertEqual(::leaveCount, 0);
        _test.endTest();
    }
}
