function start(){
    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    _world.setPlayerLoadRadius(100);
    _world.createWorld();
    _slotManager.setCurrentMap("TerrainMapFilled");

    ::playerPos <- SlotPosition();
    ::defaultSpeed <- 2;
    ::speed <- defaultSpeed;
    ::stage <- 0;
}

function genSpeed(currentSpeed){
    local outSpeed = currentSpeed;

    if(outSpeed > 10){
        outSpeed = defaultSpeed;
    }else outSpeed = outSpeed * 2

    return outSpeed;
}

function update(){

    if(stage == 0){
        playerPos.move(speed 0, 0);

        if(playerPos.slotX >= 2){
            stage++;
        }
    }
    if(stage == 1){
        playerPos.move(0, 0, speed);
        if(playerPos.slotY >= 3){
            stage++;
        }
    }
    if(stage == 2){
        playerPos.move(-speed 0, 0);
        if(playerPos.slotX < 0){
            stage++;
        }
    }
    if(stage == 3){
        playerPos.move(0, 0, -speed);
        if(playerPos.slotY < 0){
            stage=0;
            speed = genSpeed(speed);
        }
    }

    _world.setPlayerPosition(playerPos);
    local pos = playerPos.toVector3();
    _camera.setPosition(pos[0], pos[1] + 100, pos[2] + 100);
    _camera.lookAt(pos[0], pos[1], pos[2]);
}
