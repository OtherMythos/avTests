function collisionFunction(){
    //print("calling");
}

function start(){
    _world.createWorld();

    _camera.setPosition(0, 60, 120);
    _camera.lookAt(20, 0, 20);

    ::count <- 0;
    ::objectsContainer <- [];
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
    objectsContainer.clear();

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

    local pos = (_random.randVec3() * 10) - 5;
    local object = _physics.collision[0].createSender(creationSenderTable, cubeShape, pos);

    pos = (_random.randVec3() * 10) - 5;
    local receiver = _physics.collision[0].createReceiver(creationReceiverTable, cubeShape, pos);
    _physics.collision[0].addObject(object);
    _physics.collision[0].addObject(receiver);

    //Create an object which is never inserted into the world.
    //This checks the destruction procedure works even if not inserted.
    local danglingObject = _physics.collision[0].createSender(creationSenderTable, cubeShape, pos);
    ::objectsContainer.append(danglingObject);

    //We need to keep track of it.
    ::objectsContainer.append(object);
    ::objectsContainer.append(receiver);
}

function update(){
    //Each frame create a new sender and receiver, as well as destroy one of the old ones.
    ::count++;

    //Remove two random objects.
    if(::objectsContainer.len() > 0){
        for(local i = 0; i < 2; i++){
            ::objectsContainer.remove(_random.randInt(::objectsContainer.len() - 1));
        }
    }
    //Add two more.
    createSenderAndReceiver();

    if(count >= 100){
        destroyCreateWorld();
        count = 0;
    }
}
