//A test to check that collision object callbacks can properly be called with the correct parameters.

function start(){
    ::emptyCount <- 0;
    ::firstCount <- 0;
    ::secondCount <- 0;
    ::objects <- [];
    _world.createWorld();

    local initialTable = {
        "path" : "res://squirrelEntry.nut",
        "func" : "emptyCallback"
        "id" : 1,
        "type" : _COLLISION_PLAYER,
        "event" : _COLLISION_INSIDE
    };
    local receiverInfo = {
        "type" : _COLLISION_PLAYER,
    };

    local cubeShape = _physics.getCubeShape(1, 1, 1);
    ::receiver <- _physics.collision[0].createReceiver(receiverInfo, cubeShape);

    foreach(c,i in ["emptyCallback", "firstCallback", "secondCallback"]){
        initialTable.func = i;
        initialTable.id = c;

        local object = _physics.collision[0].createSender(initialTable, cubeShape);
        _physics.collision[0].addObject(object);
        //We need to keep track of it.
        objects.append(object);
    }

    _physics.collision[0].addObject(receiver);
}

function emptyCallback(){
    ::emptyCount++;
}

function firstCallback(id){
    _test.assertEqual(1, id);
    ::firstCount++;
}

function secondCallback(id, eventType){
    _test.assertEqual(2, id);
    _test.assertEqual(_COLLISION_INSIDE, eventType);
    ::secondCount++;
}

function update(){
    if(::emptyCount > 20 && ::firstCount > 20 && ::secondCount > 20){
        //The callback function was called correctly.
        _test.endTest();
    }
}
