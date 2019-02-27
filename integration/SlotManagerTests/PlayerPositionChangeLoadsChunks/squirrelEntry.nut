_world.createWorld();
_world.setPlayerLoadRadius(25);

function update(){
    if(!("start" in getroottable())){
        getroottable().start <- time();
        getroottable().stage <- 0;
    }

    if(stage == 0){

    }

    local timeDiff = time() - start;
    if(timeDiff >= 60){
        _test.assertTrue(false);
        _test.endTest();
    }
}
