//A test to check the origin shifting of chunks.
//When an origin shift is performed, the chunks should be moved so that they're positioned relative to the origin.
//This test checks to make sure that this shift actually occurred.

function start(){
    ::stage <- 0;

    _world.setPlayerLoadRadius(1);
    _world.createWorld();

    _world.setPlayerPosition(SlotPosition(0, 0, 25, 0, 25));

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);
}

function update(){
    if(stage == 0){
        local startPos = _test.slotManager.getChunkVectorPosition(0);
        ::chunkPos <- startPos;
        _test.assertEqual(0, startPos[0]);
        _test.assertEqual(0, startPos[1]);
        _test.assertEqual(0, startPos[2]);

        stage++;
    }
    if(stage == 1){
        //Move the slot position by ten.
        //The position of the one chunk should be moved to -10, -10
        _slotManager.setOrigin(SlotPosition(0, 0, 10, 0, 10));

        ::chunkPos <- _test.slotManager.getChunkVectorPosition(0);
        _test.assertEqual(-10, chunkPos[0]);
        _test.assertEqual(0, chunkPos[1]);
        _test.assertEqual(-10, chunkPos[2]);

        stage++;
    }
    if(stage == 2){
        //50 is the size of a slot, so -1, -1 and 40 would map to 10
        _slotManager.setOrigin(SlotPosition(-1, -1, 40, 0, 40));

        ::chunkPos <- _test.slotManager.getChunkVectorPosition(0);
        _test.assertEqual(10, chunkPos[0]);
        _test.assertEqual(0, chunkPos[1]);
        _test.assertEqual(10, chunkPos[2]);

        stage++;
    }
    if(stage == 3){
        _slotManager.setOrigin(SlotPosition(100, 100, 0, 0, 0));

        ::chunkPos <- _test.slotManager.getChunkVectorPosition(0);
        _test.assertEqual(-5000, chunkPos[0]);
        _test.assertEqual(0, chunkPos[1]);
        _test.assertEqual(-5000, chunkPos[2]);

        stage++;
    }
    if(stage == 4){
        _test.endTest();
    }
}
