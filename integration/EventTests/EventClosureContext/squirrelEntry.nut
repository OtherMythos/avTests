//A test to check contexts can be applied to called functions.

::targetTable <- {
    "value": 10,

    "worldCreatedCallback": function(id, data){
        _test.assertEqual(id, _EVENT_WORLD_CREATED);
        _test.assertTrue("value" in this);
        ::worldCreatedCount++;
    }
}

function start(){
    _event.subscribe(_EVENT_WORLD_CREATED, targetTable.worldCreatedCallback, targetTable);

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
        //Ensure if the table is deleted, the callback can still be called correctly.
        ::targetTable = null;
        _world.destroyWorld();
        _world.createWorld();
        stage++;
    }
    else if(stage == 2){
        _test.assertEqual(::worldCreatedCount, 2);
        _test.endTest();
    }
}
