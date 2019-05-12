//Serialise and deserialise the world, checking that the things setup in the previous world are still there.

function start(){
    _world.createWorld();

    _serialisation.clearAllSaves();
    _test.assertTrue(_settings.getSaveDirectoryViable());

    ::stage <- 0
}

function checkInitialHandle(){
    _test.assertEqual(_world.getPlayerPosition(), playerPos);
    _test.assertEqual(_slotManager.getCurrentMap(), currentMap);

    _test.assertEqual(_test.entityManager.getEntityCount(), 1);
}

function update(){
    if(stage == 0){
        _world.createWorld();

        //Set positions.
        ::currentMap <- "map";
        _slotManager.setCurrentMap(currentMap);
        ::playerPos <- SlotPosition(1, 2, 50, 50, 50);
        _world.setPlayerPosition(playerPos);

        //Put some stuff in the world.
        local en = _entity.create(SlotPosition());
        _component.mesh.add(en, "ogrehead2.mesh");

        ::handle <- SaveHandle();
        handle.saveName = "firstSave";
        _world.serialise(handle);

        stage++;
    }
    if(stage == 1){
        if(_world.ready()) stage++;
    }
    if(stage == 2){
        _world.destroyWorld();

        _world.createWorld(::handle);
        stage++;
    }
    if(stage == 3){
        if(_world.ready()) stage++;
    }
    if(stage == 4){
        checkInitialHandle();

        //Now add another entity to this world, so there will be one tracked and one untracked.
        local en = _entity.createTracked(_world.getPlayerPosition());
        _component.mesh.add(en, "ogrehead2.mesh");
        //Add a script for fun.
        _component.script.add(en, _settings.getDataDirectory() + "/EntityScript.nut");

        ::handleSecond <- SaveHandle();
        handleSecond.saveName = "secondSave";
        _world.serialise(handleSecond);

        stage++;
    }
    if(stage == 5){
        if(_world.ready()) stage++;
    }
    if(stage == 6){
        _world.destroyWorld();

        _world.createWorld(::handleSecond);
        stage++;
    }
    if(stage == 7){
        if(_world.ready()) stage++;
    }
    if(stage == 8){
        _test.assertEqual(_world.getPlayerPosition(), playerPos);
        _test.assertEqual(_slotManager.getCurrentMap(), currentMap);

        _test.assertEqual(_test.entityManager.getEntityCount(), 2);
        _test.assertEqual(_test.entityManager.getTrackedEntityCount(), 1);
        _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);

        stage++;
    }
    if(stage == 9){
        //Now if we load the initial save back in we should get the same values as before.

        _world.destroyWorld();

        _world.createWorld(::handle);
        stage++;
    }
    if(stage == 10){
        if(_world.ready()) stage++;
    }
    if(stage == 11){
        checkInitialHandle();
        
        _serialisation.clearAllSaves();
        _test.endTest();
    }
}
