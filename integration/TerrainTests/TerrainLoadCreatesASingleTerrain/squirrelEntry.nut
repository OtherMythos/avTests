

function start(){
    _world.setPlayerLoadRadius(25);
    _world.createWorld();
    _slotManager.setCurrentMap("TerrainMap");

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    ::stage <- 0;
    ::stageCount <- 0;
}

function update(){
    
    if(stage == 0){
        if(_test.slotManager.getInUseTerrains() == 1){
            stageCount++;
        }
        if(stageCount >= 20){ //Hang on that for a little while, just so you can see the terrain.
            stage++;
            stageCount = 0;
        }
    }
    if(stage == 1){
        _world.setPlayerPosition(SlotPosition(5, 5)); //With this the old terrain should be released, and the counts in the list should change.
        stage++;
    }
    if(stage == 2){
        _test.assertEqual(_test.slotManager.getInUseTerrains(), 0);
        _test.assertEqual(_test.slotManager.getAvailableTerrains(), 1);

        stageCount++;
        if(stageCount >= 20){
            stageCount = 0;
            stage++;
        }
    }
    if(stage == 3){
        _world.setPlayerPosition(SlotPosition()); //Reset back to the origin. The old terrain should be loaded again.
        stage++;
    }
    if(stage == 4){
        //No new terrains should be created, the old one should just be recycled.
        _test.assertEqual(_test.slotManager.getInUseTerrains(), 1);
        _test.assertEqual(_test.slotManager.getAvailableTerrains(), 0);

        stageCount++;
        if(stageCount >= 20){
            _test.endTest();
        }
    }
}
