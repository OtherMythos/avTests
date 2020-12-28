//A test to check that collision object creation tables throw the appropriate errors during failure.

function start(){
    ::count <- 0;
    ::emptyCount <- 0;
    ::objects <- [];
    _world.createWorld();

    local tableData = [
        { //Testing closures, the script should do nothing if provided with something that isn't a closure.
            "id" : 5,
            "type" : _COLLISION_PLAYER,
            "event" : _COLLISION_INSIDE,
            "func" : count
        },
        { //Invalid key
            "id" : 5,
            "type" : _COLLISION_PLAYER,
            "event" : _COLLISION_INSIDE,
            "InvalidKey": 1020
        },
        { //Invalid type in valid key
            "id" : 5,
            "type" : _COLLISION_PLAYER,
            "event" : "something invalid"
        }
    ];
    local receiverInfo = {
        "type" : _COLLISION_PLAYER,
    };

    local cubeShape = _physics.getCubeShape(1, 1, 1);

    foreach(c,i in tableData){
        local failed = false;
        try{
            local object = _physics.collision[0].createSender(i, cubeShape);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
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
