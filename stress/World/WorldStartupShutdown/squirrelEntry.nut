function start(){
    _camera.setPosition(0, 0, 100);
    _camera.lookAt(0, 0, 0);

    ::count <- 0;
    ::worldsCreated <- 0;
    ::pos <- SlotPosition();
}

function update(){
    count++;

    if(count == 300){
        _world.createWorld();
        _slotManager.setCurrentMap("map");

        local en = _entity.create(SlotPosition());
        _component.mesh.add(en, "ogrehead2.mesh");

        print("Worlds created: " + worldsCreated);
    }

    if(count > 300 && count < 600){
        pos.move(3, 0, 0);

        _world.setPlayerPosition(pos);
    }

    if(count == 600){
        _world.destroyWorld();

        count = 0;
        worldsCreated++;
        pos = SlotPosition();
    }
}
