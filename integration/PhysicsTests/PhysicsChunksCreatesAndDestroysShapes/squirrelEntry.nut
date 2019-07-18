//A test to check that physics chunks create shapes, and that when the chunks are destroyed the shapes are destroyed as well.

function start(){
    _slotManager.setCurrentMap("physicsTestMap");
    _world.setPlayerLoadRadius(1);
    //Half way through the first chunk. There should only be the single chunk loaded.
    _world.setPlayerPosition(SlotPosition(0, 0, 25, 0, 25));

    _world.createWorld();

    ::stage <- 0;
    ::stageCount <- 0;
}

function update(){
    //Check the shapes defined in the chunk file are loaded as intended.

    if(stage == 0){
        _test.assertTrue(_test.physics.getShapeExists(0, 5, 1, 5));
        _test.assertTrue(_test.physics.getShapeExists(0, 20, 30, 40));

        //TODO this should be testing shapes other than cubes as well, but I don't use them as of yet, so I haven't got round to do doing that.

        stageCount++;
        if(stageCount > 10){
            stage++;
        }
    }
    if(stage == 1){
        //Now move somewhere where there are no physics chunks.
        //The previous chunks should be destroyed, along with the shapes.
        _world.setPlayerPosition(SlotPosition(-1, -1, 25, 0, 25));
        stageCount = 0;
        stage++;
    }
    if(stage == 2){
        _test.assertFalse(_test.physics.getShapeExists(0, 5, 1, 5));
        _test.assertFalse(_test.physics.getShapeExists(0, 20, 30, 40));

        stageCount++;
        if(stageCount > 10){
            _test.endTest();
        }
    }
}
