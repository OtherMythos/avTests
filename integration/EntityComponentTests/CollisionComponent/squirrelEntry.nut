//A test to check that multiple collison objects can be assigned to entities, and that these objects then move as the entities move.

function receiverFunction(){
    //If there's a collision, this is because of the entity movement.
    _test.endTest();
}

function start(){
    _world.createWorld();

    _camera.setPosition(0, 0, 100);
    _camera.lookAt(0, 0, 0);

    ::count <- 0;
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

    ::body <- _physics.collision[0].createReceiver(receiverInfo, _physics.getCubeShape(1, 1, 1));
    ::sender <- _physics.collision[0].createSender(senderTable, _physics.getSphereShape(1));

    _component.collision.add(en, body);
    _component.collision.add(en2, sender);

    en2.setPosition(SlotPosition(0, 0, 10, 0, 0));

    _physics.collision[0].addObject(body);
    _physics.collision[0].addObject(sender);
}

function update(){
    count++;

    //Quickly test both 3 floats and a vec3 work.
    en.move(Vec3(0.1, 0, 0));
    en2.move(-0.1, 0, 0);
}
