//A test to check that you can set the current map before the world is even started up.
//When the world starts up it should start by creating this map rather than any other map.

function start(){
    //With the player at the origin, with chunks of 50, 25 means only 4 chunks should be loaded.
    _world.setPlayerLoadRadius(25);
    _slotManager.setCurrentMap("map");
    _world.createWorld();

    ::count <- 0;
}

function update(){

    //An empty string is the default map.
    //If the change wasn't applied correctly, this would be set in its place.
    _test.assertEqual(_test.slotManager.getNumChunksOfMap(""), 0);

    _test.assertEqual(_test.slotManager.getNumChunksOfMap("map"), 4);

    //Wait for a few frames.
    if(count > 10){
        _test.endTest();
    }

    count++;
}
