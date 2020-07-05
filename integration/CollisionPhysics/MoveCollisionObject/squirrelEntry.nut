//A test to check that the set position function causes events to be triggered on occurance.

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
        //Set the position so that they no longer intersect.
        ::sender.setPosition(20, 20, 20);
        stage++;
    }else if(stage == 2){
        _test.assertEqual(::insideCount, 1);
        _test.assertEqual(::enterCount, 1);
        if(leaveCount == 1){
            _test.assertEqual(::leaveCount, 1);
            ::stageCount++;
            if(stageCount >= 20){ //Check it idles like this for a while
                ::sender.setPosition(0, 0, 0);
                stage++;
            }
        }
    }else if(stage == 3){
        //It's difficult to check this absolutely, as there's a bit of back and forth between the thread and the script.
        //So I just have to wait in this loop until they both are true, which should only be one or two frames anyway.
        //If this doesn't become true, the timeout will fail.
        if(enterCount == 2 && insideCount == 2){
            _test.endTest();
        }
    }
}
