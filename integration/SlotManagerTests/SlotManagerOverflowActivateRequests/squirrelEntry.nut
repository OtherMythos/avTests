
function start(){
    _world.createWorld();
    _world.setPlayerLoadRadius(0);

    ::stage <- 0;
    ::startTime <- time();
}

function update(){
    if(stage == 0){
        for(local y = 0; y < 10; y++){
            for(local x = 0; x < 10; x++){
                _test.slotManager.activateChunk("map", x, y);
            }
        }
        stage++;
    }
    if(stage == 1){
        local chunkListSize = _test.slotManager.getChunkListSize();

        if(chunkListSize == 100){
            print("All chunks loaded.")
            _test.endTest();
        }
    }

    local timeDiff = time() - startTime;
    if(timeDiff >= 60){
        _test.assertTrue(false);
        _test.endTest();
    }
}
