
function firstWorldCallback(){

}

function start(){
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

    local object = _physics.collision[0].createSender(senderData, cubeShape);
    local receiver = _physics.collision[0].createReceiver(receiverInfo, cubeShape);

    _test.assertNotEqual(object.getInternalId(), receiver.getInternalId());
    receiver = null;
    local receiver = _physics.collision[0].createReceiver(receiverInfo, cubeShape);
    _test.assertNotEqual(object.getInternalId(), receiver.getInternalId());

    _test.endTest();

}

function update(){

}
