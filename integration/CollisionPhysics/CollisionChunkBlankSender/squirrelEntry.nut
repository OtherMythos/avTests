//Test that if a collision occurs between a sender and receiver where the sender has nothing set for its script, the engine handles it gracefully.

function start(){
    ::currentPos <- SlotPosition();
    _world.createWorld();

    _slotManager.setCurrentMap("physicsTestMap");

    _world.setPlayerPosition(SlotPosition());
    _world.setPlayerLoadRadius(150);

    local cubeShape = _physics.getCubeShape(1, 1, 1);
    ::receiver <- _physics.collision[0].createReceiver({"type" : _COLLISION_PLAYER}, cubeShape);
    _physics.collision[0].addObject(::receiver);

    _camera.setPosition(0, 0, 300);
    _camera.lookAt(0, 0, 0);

}

function update(){
    currentPos.move(1, 0, 0)

    receiver.setPosition(currentPos);

    if(currentPos.slotX >= 1){
        //This means the receiver traveled through the sender without any problems.
        _test.endTest();
    }
}
