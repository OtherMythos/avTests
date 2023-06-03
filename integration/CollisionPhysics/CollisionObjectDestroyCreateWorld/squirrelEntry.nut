//A test to check that objects are destroyed correctly when the world is shutdown and re-created.

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
        if(insideCount >= 10) stage++;
    }else if(stage == 2){
        _physics.collision[0].removeObject(::sender);
        _physics.collision[0].removeObject(::receiver);
        _world.destroyWorld();
        stage++;
    }else if(stage == 3){
        //Ensure there is no gunk left over from the previous world.
        print("World created");
        _world.createWorld();
        stage++;

        insideCount = 0;
        enterCount = 0;
        leaveCount = 0;

        _physics.collision[0].addObject(::sender);
        _physics.collision[0].addObject(::receiver);
    }else if(stage == 4){
        //Wait a bit for something to happen.
        if(insideCount >= 20){
            stage++;
        }
    }else if(stage == 5){
        _test.endTest();
    }
}
