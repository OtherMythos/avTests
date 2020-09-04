//A test to check system events can be subscribed to and received correctly.

function worldCreatedCallback(id, data){
    _test.assertEqual(id, _EVENT_WORLD_CREATED);
    print("window resized event");
    ::worldCreatedCount++;
}

function worldDestroyedCallback(id, data){
    _test.assertEqual(id, _EVENT_WORLD_DESTROYED);
    print("Engine closed event");
    ::worldDestroyedCount++;
}

function start(){
    _event.subscribe(_EVENT_WORLD_CREATED, worldCreatedCallback);
    _event.subscribe(_EVENT_WORLD_DESTROYED, worldDestroyedCallback);

    local errorFound = false;
    try{
        //Subscribing to null should throw an error.
        _event.subscribe(_EVENT_NULL, worldDestroyedCallback);
    }catch(e){
        errorFound = true;
    }
    _test.assertTrue(errorFound);

    ::worldCreatedCount <- 0;
    ::worldDestroyedCount <- 0;

    ::stage <- 0;
}

function update(){
    if(stage == 0){
        _world.createWorld();
        stage++;
    }
    else if(stage == 1){
        _test.assertEqual(::worldCreatedCount, 1);
        _world.destroyWorld();
        stage++;
    }
    else if(stage == 2){
        _test.assertEqual(::worldDestroyedCount, 1);

        _test.endTest();
    }
}
