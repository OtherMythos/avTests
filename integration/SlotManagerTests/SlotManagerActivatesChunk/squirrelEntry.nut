
function start(){
    //Set this to 0 so no other chunks are loaded automatically.
    //This should be done at the start of execution so no other chunks are accidentally loaded.
    _world.setPlayerLoadRadius(0);
    _slotManager.setCurrentMap("first");


    _world.createWorld();

    _test.slotManager.activateChunk("map", 1, 2);
}

function update(){
    print("Checking for chunk");
    local chunkListSize = _test.slotManager.getChunkListSize();
    print("Chunk list has size " + chunkListSize);

    if(chunkListSize == 1){
        print("Found the chunk!")
        //Make sure it is active.
        local val = _test.slotManager.getChunkActive(0);

        print("Chunk active state is " + val)
        _test.assertTrue(val);
        _test.endTest();
    }else{
        print("Chunk not found.");
    }
}
