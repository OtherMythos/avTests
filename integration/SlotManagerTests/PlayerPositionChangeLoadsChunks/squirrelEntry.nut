_world.createWorld();
_world.setPlayerLoadRadius(25);

function update(){
    if(!("start" in getroottable())){
        getroottable().start <- time();
        getroottable().stage <- 0;
        getroottable().currentPosition <- SlotPosition();

        _camera.setPosition(0, 100, 100);
        _camera.lookAt(0, 0, 0);
    }

    if(stage == 0){
        //The player position is set to the origin. Move it around and see it do things.
        currentPosition.move(0.5, 0, 0);

        _world.setPlayerPosition(currentPosition);
        local absPos = currentPosition.toVector3();
        _camera.setPosition(absPos[0], absPos[1] + 100, absPos[2] + 100);

        //TODO, as the player position moves, check to make sure that things are unloaded and loaded properly.
        if(currentPosition.slotX >= 4){
            stage++;
        }
    }
    if(stage == 1){
        print("Different stage");
    }

    local timeDiff = time() - start;
    if(timeDiff >= 60){
        _test.assertTrue(false);
        _test.endTest();
    }
}
