
function start(){
    //Set this to 0 so no other chunks are loaded automatically.
    _world.setPlayerLoadRadius(0);
    _world.createWorld();

    _test.slotManager.constructChunk("map", 1, 2);
}

function update(){
    print("Checking for chunk");
    local chunkListSize = _test.slotManager.getChunkListSize();
    print("Chunk list has size " + chunkListSize);

    if(chunkListSize == 1){
        print("Found the chunk!");
        //Make sure it's not active.
        local val = _test.slotManager.getChunkActive(0);

        print("Chunk active state is " + val)
        _test.assertFalse(val);
        _test.endTest();
    }else{
        print("Chunk not found.");
    }
}
