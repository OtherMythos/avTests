//A test to check if the radius loader loads chunks while moving.
//The player radius is set to something small, so only a few chunks can be loaded at once, and the player position is moved around.
//The idea is that no more than a certain number of chunks are ever loaded.
//If it ever goes over this ammount (in this case 2), the test fails.

_world.setPlayerLoadRadius(20);
_world.createWorld();
_slotManager.setCurrentMap("map");

function update(){
    if(!("start" in getroottable())){
        getroottable().start <- time();
        getroottable().stage <- 0;
        getroottable().chunkTravelDistance <- 10;
        getroottable().currentPosition <- SlotPosition(0, 0, 0, 0, 25);

        _camera.setPosition(0, 100, 100);
        _camera.lookAt(0, 0, 0);
    }

    _world.setPlayerPosition(currentPosition);
    local absPos = currentPosition.toVector3();
    _camera.setPosition(absPos[0], absPos[1] + 100, absPos[2] + 100);

    local loadedSlots = _test.slotManager.getChunkListSize();
    if(loadedSlots > 2){
        //If there are more than two slots loaded at once, that means the radius is broken.
        //With the size of 50 for a slot, and 20 for the radius, with the player moving along the x there should never be more than 2.
        print("More than two slots loaded at once! Failing.")
        _test.endTest(false);
    }


    if(stage == 0){
        //The player position is set to the origin. Move it around and see it do things.
        currentPosition.move(0.5, 0, 0);

        if(currentPosition.slotX >= chunkTravelDistance){
            if(currentPosition.x >= 25){
                stage++;
            }
        }
    }
    if(stage == 1){
        currentPosition.move(0, 0, 0.5);

        if(currentPosition.slotY >= chunkTravelDistance){
            if(currentPosition.z >= 25){
                stage++;
            }
        }
    }
    if(stage == 2){
        currentPosition.move(-0.5, 0, 0);

        //-1 because we're neading into negative terratory, so need to borrow a slot for the position.
        if(currentPosition.slotX <= -chunkTravelDistance - 1){
            if(currentPosition.x <= 25){
                stage++;
            }
        }
    }
    if(stage == 3){
        currentPosition.move(0, 0, -0.5);

        if(currentPosition.slotY <= -chunkTravelDistance - 1){
            if(currentPosition.z <= 25){
                stage++;
            }
        }
    }
    if(stage == 4){
        _test.endTest();
    }

    local timeDiff = time() - start;
    if(timeDiff >= 1000){
        _test.assertTrue(false);
        _test.endTest();
    }
}
