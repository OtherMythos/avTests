//A test to check that multiple collison objects can be assigned to entities

::checkEnd <- function(){
    if(firstCollision && secondCollision){
        _test.endTest();
    }
}

function receiverFunction(){
    ::firstCollision = true;
    checkEnd();
}

function receiverFunction2(){
    ::secondCollision = true;
    checkEnd();
}

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 100);
    _camera.lookAt(0, 0, 0);

    ::firstCollision <- false;
    ::secondCollision <- false;

    ::en <- _entity.create(SlotPosition());
    ::en2 <- _entity.create(SlotPosition());

    local senderTable = {
        "func" : receiverFunction,
        "id" : 1,
        "type" : _COLLISION_PLAYER,
        "event" : _COLLISION_INSIDE
    };
    local receiverInfo = {
        "type" : _COLLISION_PLAYER,
    };

    local body = _physics.collision[0].createReceiver(receiverInfo, _physics.getCubeShape(1, 1, 1));
    local sender = _physics.collision[0].createSender(senderTable, _physics.getSphereShape(1));

    senderTable.func = receiverFunction2;
    local body2 = _physics.collision[1].createReceiver(receiverInfo, _physics.getCubeShape(1, 1, 1));
    local sender2 = _physics.collision[1].createSender(senderTable, _physics.getSphereShape(1));

    _component.collision.add(en, body, body2);
    _component.collision.add(en2, sender, sender2);

    en2.setPosition(SlotPosition(0, 0, 10, 0, 0));

    _physics.collision[0].addObject(body);
    _physics.collision[0].addObject(sender);
    _physics.collision[1].addObject(body2);
    _physics.collision[1].addObject(sender2);
}

function update(){

    //Quickly test both 3 floats and a vec3 work.
    en.move(Vec3(0.1, 0, 0));
    en2.move(-0.1, 0, 0);
}
