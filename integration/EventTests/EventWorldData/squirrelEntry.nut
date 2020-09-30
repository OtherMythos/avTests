//A test to check world events contain the correct data.

function worldMapChange(id, data){
    _test.assertNotEqual(data, null);
    _test.assertEqual(data.old, "");
    _test.assertEqual(data.new, "second");
}

function worldOriginChange(id, data){
    _test.assertNotEqual(data, null);
    _test.assertEqual(data.old, SlotPosition());
    _test.assertEqual(data.new, SlotPosition(2, 3));
}

function worldPlayerRadiusChange(id, data){
    _test.assertNotEqual(data, null);
    _test.assertEqual(data.old, 200);
    _test.assertEqual(data.new, 123);
}

function start(){
    _event.subscribe(_EVENT_WORLD_MAP_CHANGE, worldMapChange);
    _event.subscribe(_EVENT_WORLD_ORIGIN_CHANGE, worldOriginChange);
    _event.subscribe(_EVENT_WORLD_PLAYER_RADIUS_CHANGE, worldPlayerRadiusChange);

    ::stage <- 0;
}

function update(){
    if(stage == 0){
        _world.createWorld();
        _slotManager.setCurrentMap("second");
        _slotManager.setOrigin(SlotPosition(2, 3));
        _world.setPlayerLoadRadius(123);
        stage++;
    }
    else if(stage == 1){
        stage++;
    }
    else if(stage == 2){
        _test.endTest();
    }
}
