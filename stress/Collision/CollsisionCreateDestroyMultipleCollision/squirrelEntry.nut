const NUM_WORLDS = 3;

function collisionFunction(){
    //print("calling");
}

function start(){
    _world.createWorld();

    _camera.setPosition(0, 60, 120);
    _camera.lookAt(20, 0, 20);

    ::count <- 0;
    ::worldContainers <- [ [], [], [], [] ];
    ::worldExists <- true;

    ::creationSenderTable <- {
        "type" : _COLLISION_PLAYER,
        "event" : _COLLISION_INSIDE,
        "func" : collisionFunction
    };
    ::creationReceiverTable <- {
        "type" : _COLLISION_PLAYER
    };

    for(local i = 0; i < 20; i++){
        createSenderAndReceiver();
    }
}

function destroyCreateWorld(){
    worldExists = !worldExists;
    foreach(i in worldContainers){
        i.clear();
    }

    if(!worldExists){
        //Destroy it.
        _world.destroyWorld();
    }else{
        _world.createWorld();
    }

    for(local i = 0; i < 20; i++){
        createSenderAndReceiver();
    }
}

function createSenderAndReceiver(){
    local cubeShape = _physics.getCubeShape(_random.rand(), _random.rand(), _random.rand());
    local targetWorld = _random.randInt(NUM_WORLDS);

    local pos = (_random.randVec3() * 10) - 5;
    print(targetWorld)
    local object = _physics.collision[targetWorld].createSender(creationSenderTable, cubeShape, pos);

    pos = (_random.randVec3() * 10) - 5;
    local receiver = _physics.collision[targetWorld].createReceiver(creationReceiverTable, cubeShape, pos);
    _physics.collision[targetWorld].addObject(object);
    _physics.collision[targetWorld].addObject(receiver);

    //Create an object which is never inserted into the world.
    //This checks the destruction procedure works even if not inserted.
    local danglingObject = _physics.collision[targetWorld].createSender(creationSenderTable, cubeShape, pos);

    local targetContainer = ::worldContainers[targetWorld];
    targetContainer.append(danglingObject);

    //We need to keep track of it.
    targetContainer.append(object);
    targetContainer.append(receiver);
}

function update(){
    //Each frame create a new sender and receiver, as well as destroy one of the old ones.
    ::count++;

    //Remove two random objects.
    for(local y = 0; y < 2; y++){
        //Pick a world to remove from
        local targetContainer = ::worldContainers[_random.randInt(NUM_WORLDS)];

        if(targetContainer.len() > 0){
            targetContainer.remove(_random.randInt(targetContainer.len() - 1));
        }
    }
    //Add two more.
    createSenderAndReceiver();

    if(count >= 100){
        destroyCreateWorld();
        count = 0;
    }
}
