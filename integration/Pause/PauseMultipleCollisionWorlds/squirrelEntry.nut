//Test to check that pausing individual collision worlds works as expected.

function firstWorldCallback(id){
    print("first");
    ::worldCounts[id]++;
}

function secondWorldCallback(id){
    print("second");
    ::worldCounts[id]++;
}

function thirdWorldCallback(id){
    print("third");
    ::worldCounts[id]++;
}

function fourthWorldCallback(id){
    print("fourth");
    ::worldCounts[id]++;
}

function start(){
    ::stage <- 0;
    ::stageCount <- 0;
    ::emptyCount <- 0;
    ::objects <- [];
    ::worldCounts <- [0, 0, 0, 0];
    _world.createWorld();

    local senderData = {
        "func": firstWorldCallback,
        "id" : 1,
        "type" : _COLLISION_PLAYER,
        "event" : _COLLISION_INSIDE
    };
    local receiverInfo = {
        "type" : _COLLISION_PLAYER,
    };

    local cubeShape = _physics.getCubeShape(1, 1, 1);

    local targetData = [firstWorldCallback, secondWorldCallback, thirdWorldCallback, fourthWorldCallback];
    foreach(c,i in targetData){
        local targetCollisionWorld = c;
        senderData.func = i;
        senderData.id = targetCollisionWorld;

        local object = _physics.collision[targetCollisionWorld].createSender(senderData, cubeShape);
        local receiver = _physics.collision[targetCollisionWorld].createReceiver(receiverInfo, cubeShape);
        _physics.collision[targetCollisionWorld].addObject(object);
        _physics.collision[targetCollisionWorld].addObject(receiver);

        //Don't give them a position. All the objects are placed at the origin.

        //We need to keep track of it.
        objects.append(object);
        objects.append(receiver);
    }

    _state.setPauseState(_PAUSE_PHYSICS);
}

function checkWorld(target){
    ::stageCount++;
    if(stageCount >= 20){
        for(local i = 0; i < 4; i++){
            print(i);
            print(worldCounts[i]);
            if(i == target) _test.assertEqual(worldCounts[i], 0);
            else _test.assertTrue(worldCounts[i] > 0);
        }
        stage++;
        stageCount = 0;
        worldCounts = array(4, 0);
        if(target == 3){
            _state.setPauseState(0);
        }else{
            _state.setPauseState(_PAUSE_PHYSICS_COLLISION0 << target+1);
        }
    }
}

function update(){

    if(stage == 0){
        ::stageCount++;
        foreach(i in worldCounts){
            _test.assertEqual(i, 0);
        }
        if(stageCount >= 50){
            stage++;
            stageCount = 0;
            //Should just be physics work 0.
            _state.setPauseState(_PAUSE_PHYSICS_COLLISION0);
        }
    }
    else if(stage == 1){
        checkWorld(0);
    }
    else if(stage == 2){
        checkWorld(1);
    }
    else if(stage == 3){
        checkWorld(2);
    }
    else if(stage == 4){
        checkWorld(3);
    }
    else if(stage == 5){
        _test.endTest();
    }
}
