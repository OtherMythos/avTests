//A test to check that collision objects can be created by tables, properly sanity checked for issues.

function start(){
    ::count <- 0;
    ::emptyCount <- 0;
    ::objects <- [];
    _world.createWorld();

    local tableData = [
        { //No script information.
            "id" : 1,
            "type" : _COLLISION_PLAYER,
            "event" : _COLLISION_INSIDE
        },
        { //Missing function. Without that nothing should be loaded.
            "id" : 2,
            "type" : _COLLISION_PLAYER,
            "event" : _COLLISION_INSIDE,
            "path" : "someNonsense"
        },
        { //Invalid file. Even with a correct closure nothing should be loaded.
            "id" : 3,
            "type" : _COLLISION_PLAYER,
            "event" : _COLLISION_INSIDE,
            "path" : "someNonsense",
            "func" : "emptyCallback"
        },
        { //Invalid function(closure). The script will be loaded to check it, and then dereferences when it's not found.
            "id" : 4,
            "type" : _COLLISION_PLAYER,
            "event" : _COLLISION_INSIDE,
            "path" : "res://squirrelEntry.nut",
            "func" : "nonsense"
        },
        { //Testing closures, the script should do nothing if provided with something that isn't a closure.
            "id" : 5,
            "type" : _COLLISION_PLAYER,
            "event" : _COLLISION_INSIDE,
            "func" : count
        },
        { //If the id is not provided, it should default to 0.
            "type" : _COLLISION_PLAYER,
            "event" : _COLLISION_INSIDE,
            "func" : checkDefaultId
        }
    ];
    local receiverInfo = {
        "type" : _COLLISION_PLAYER,
    };

    local cubeShape = _physics.getCubeShape(1, 1, 1);

    foreach(c,i in tableData){
        local object = _physics.collision[0].createSender(i, cubeShape);
        _physics.collision[0].addObject(object);
        local receiver = _physics.collision[0].createReceiver(receiverInfo, cubeShape);
        _physics.collision[0].addObject(receiver);


        local pos = Vec3(c, c, c) * 10;
        receiver.setPosition(pos);
        object.setPosition(pos);

        //We need to keep track of it.
        objects.append(object);
        objects.append(receiver);
    }

}

function emptyCallback(){
    ::emptyCount++;
}

function checkDefaultId(id){
    _test.assertEqual(0, id);
}

function update(){
    count++;
    _test.assertEqual(emptyCount, 0);
    if(count > 20){
        //The callback function was called correctly.
        _test.endTest();
    }
}
