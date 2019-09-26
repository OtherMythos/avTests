//An error I saw when writing the terrain implementation was derived from having an invalid resources file.
//As the terrain ended up relying on essential files, there was a bug where no resources were processed if the resources file was invalid, not even the essential ones.
//This test just starts up a setup file with an invalid resources file, and checks that the enigne doesn't crash.


function start(){
    _world.setPlayerLoadRadius(25);
    _world.createWorld();
    _slotManager.setCurrentMap("TerrainMap");

    ::count <- 0;
}

function update(){
    count++;

    if(count >= 10){ //Hang about for a bit to check there is no crash.
        _test.endTest();
    }
}
