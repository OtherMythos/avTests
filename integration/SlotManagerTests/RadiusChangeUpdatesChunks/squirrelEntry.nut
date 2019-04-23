//Set the radius to be 25. 4 chunks should be loaded in a world with a slot size of 50.
//I used 50 because I wanted to try a different number than the default in the avSetup file.

function start(){
    ::stage <- 0;

    _world.setPlayerLoadRadius(25);
    _world.createWorld();
}

function update(){
    if(stage == 0){
        //Check that the 4 chunks are loaded.
        local chunkListSize = _test.slotManager.getChunkListSize();
        print(chunkListSize)

        if(chunkListSize == 4){
            stage++;
        }
    }
    if(stage == 1){
        //Now increase the size of the radius to 50.
        _world.setPlayerLoadRadius(51);
        stage++;
    }
    if(stage == 2){
        local chunkListSize = _test.slotManager.getChunkListSize();

        if(chunkListSize == 12){
            stage++;
        }
    }
    if(stage == 3){
        //Shrink to 0 and make sure everything is unloaded.
        _world.setPlayerLoadRadius(0);
        stage++;
    }
    if(stage == 4){
        local chunkListSize = _test.slotManager.getChunkListSize();
        print(chunkListSize);

        if(chunkListSize == 0){
            _test.endTest();
        }
    }
}
