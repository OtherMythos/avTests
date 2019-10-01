//Move the player position to an area which reaches the chunk limit.
//At the moment I'm just checking the engine doesn't crash.

function start(){
    ::stage <- 0;
    ::stageCount <- 0;

    _world.setPlayerLoadRadius(25);
    _world.createWorld();
}

function update(){
    if(stage == 0){
        _world.setPlayerPosition(SlotPosition(10000, 10000)); //An out of bounds position.
        stage++;
    }
    if(stage == 1){
        stageCount++;
        if(stageCount >= 100){
            stage++;
            stageCount = 0;
        }
    }
    if(stage == 2){
        _world.setPlayerPosition(SlotPosition(-10000, -10000));

        stage++;
    }
    if(stage == 3){
        stageCount++;
        if(stageCount >= 100){
            stage++;
        }
    }
    if(stage == 4){
        _test.endTest();
    }
}
