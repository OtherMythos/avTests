//A test to check that events can be unsubscribed from.

function worldCreatedCallback(id, data){
    _test.assertEqual(id, _EVENT_WORLD_CREATED);
    print("window resized event");
    ::worldCreatedCount++;
}

function start(){
    _event.subscribe(_EVENT_WORLD_CREATED, worldCreatedCallback);

    ::worldCreatedCount <- 0;

    ::stage <- 0;
}

function update(){
    if(stage == 0){
        _world.createWorld();
        stage++;
    }
    else if(stage == 1){
        _test.assertEqual(::worldCreatedCount, 1);
        _event.subscribe(_EVENT_WORLD_CREATED, null);
        _world.destroyWorld();
        _world.createWorld();
        stage++;
    }
    else if(stage == 2){
        //Skip a frame to wait for it
        stage++;
    }
    else if(stage == 3){
        //The amount should not have been increased because of the unsubscribe.
        _test.assertEqual(::worldCreatedCount, 1);
        _event.subscribe(_EVENT_WORLD_CREATED, worldCreatedCallback);
        _world.destroyWorld()
        _world.createWorld()
        stage++;
    }
    else if(stage == 4){
        _test.assertEqual(::worldCreatedCount, 2);
        _test.endTest();
    }
}
