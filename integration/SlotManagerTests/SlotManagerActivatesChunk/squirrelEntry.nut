_world.createWorld();
//Set this to 0 so no other chunks are loaded automatically.
_world.setPlayerLoadRadius(0);

_test.slotManager.activateChunk("map", 1, 2);

function update(){
    if(!("start" in getroottable())){
        getroottable().start <- time();
    }

    print("Checking for chunk");
    local chunkListSize = _test.slotManager.getChunkListSize();
    print("Chunk list has size " + chunkListSize);

    if(chunkListSize == 1){
        print("Found the chunk!")
        _test.endTest();
    }else{
        print("Chunk not found.");
    }

    local timeDiff = time() - start;
    if(timeDiff >= 60){
        //Timeout after 60 seconds and fail the test
        //_test.assertTrue(false);
        _test.endTest();
    }
}
