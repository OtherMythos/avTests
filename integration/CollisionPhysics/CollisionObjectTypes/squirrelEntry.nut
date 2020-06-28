//A test to check that correct object types lead to callbacks being called.

function start(){
    ::objects <- [];
    ::values <- array(5, false);
    ::expected <- [true, true, false, true, false];
    _world.createWorld();

    local initialTable = {
        "path" : "res://squirrelEntry.nut",
        "func" : "functionCallback"
        "id" : 1,
        "type" : _COLLISION_PLAYER,
        "event" : _COLLISION_INSIDE
    };
    local receiverInfo = {
        "type" : _COLLISION_PLAYER,
    };

    local cubeShape = _physics.getCubeShape(1, 1, 1);

    local values = [
        [_COLLISION_PLAYER, _COLLISION_PLAYER],
        [_COLLISION_PLAYER | _COLLISION_ENEMY | _COLLISION_OBJECT | _COLLISION_USER_3 | _COLLISION_USER_4 | _COLLISION_USER_5 | _COLLISION_USER_6, _COLLISION_PLAYER],
        [_COLLISION_PLAYER, _COLLISION_ENEMY],
        [_COLLISION_PLAYER | _COLLISION_ENEMY | _COLLISION_OBJECT | _COLLISION_USER_3 | _COLLISION_USER_4 | _COLLISION_USER_5 | _COLLISION_USER_6, _COLLISION_PLAYER | _COLLISION_ENEMY | _COLLISION_OBJECT | _COLLISION_USER_3 | _COLLISION_USER_4 | _COLLISION_USER_5 | _COLLISION_USER_6],
        //Everything, but without the player.
        [_COLLISION_ENEMY | _COLLISION_OBJECT | _COLLISION_USER_3 | _COLLISION_USER_4 | _COLLISION_USER_5 | _COLLISION_USER_6, _COLLISION_PLAYER],
    ];
    foreach(c,i in values){
        initialTable.id = c;
        initialTable.type = i[0];

        receiverInfo.type = i[1];

        local object = _physics.collision[0].createSender(initialTable, cubeShape);
        _physics.collision[0].addObject(object);
        //We need to keep track of it.

        local receiver = _physics.collision[0].createReceiver(receiverInfo, cubeShape);
        _physics.collision[0].addObject(receiver);

        //To separate them so they don't interfere with one another.
        local positionVec = Vec3(c, c, c) * 10;
        object.setPosition(positionVec);
        receiver.setPosition(positionVec);

        objects.append(object);
        objects.append(receiver);
    }

}

function functionCallback(id, eventType){
    ::values[id] = true;
}

function update(){
    local allTrue = true;
    for(local i = 0; i < values.len(); i++){
        if(values[i] != expected[i]){
            allTrue = false;
            break;
        }
    }

    if(allTrue){
        _test.endTest();
    }
}
