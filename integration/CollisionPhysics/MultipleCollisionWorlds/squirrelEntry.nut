//A test to check that multiple collision worlds do not interfere with each other's collision events.

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
    ::count <- 0;
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

}

function update(){
    count++;

    foreach(i in worldCounts){
        /**
        None of the counters should pass 25 (the 5 is a buffer), as we're only looping 20 frames.
        Say for instance a bug is present and all objects end up in world 0, more callbacks will be called for that world, so there's no balance, and it fails.
        */
        _test.assertTrue(i <= 25);
    }

    if(count >= 20){
        _test.endTest();
    }
}
