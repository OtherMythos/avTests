//A test to check that the origin of a collision object as well as the rotation can be set with a construction info table.

function functionCallback(id){
    ::collided = true;
}

function start(){
    _world.createWorld();
    ::collided <- false;

    _camera.setPosition(Vec3(0, 20, 80));
    _camera.lookAt(Vec3(0, 0, 0));

    local initialTable = {
        "func" : functionCallback,
        "id" : 1,
        "type" : _COLLISION_PLAYER,
        "event" : _COLLISION_INSIDE | _COLLISION_ENTER | _COLLISION_LEAVE,
        "origin": Vec3(10, 20, 30),
        "rotation": Quat(1, 1, 0, 0)
    };
    local receiverInfo = {
        "type" : _COLLISION_PLAYER,
    };

    local cubeShape = _physics.getCubeShape(1, 1, 1);
    local cubeShapeSender = _physics.getCubeShape(10, 1, 10);

    //One has its origin hard coded in the function. One does not.
    ::sender <- _physics.collision[0].createSender(initialTable, cubeShapeSender);
    ::receiver <- _physics.collision[0].createReceiver(receiverInfo, cubeShape, Vec3(10, 25, 30));

    _physics.collision[0].addObject(sender);
    _physics.collision[0].addObject(receiver);

}

function update(){
    if(::collided){
        _test.endTest();
    }
}
