//Create an entity and check that the entity count in the entity manager goes up.

function start(){
    _world.createWorld();
}

function update(){
    local e = _entity.create(SlotPosition());

    local count = _test.entityManager.getEntityCount();
    _test.assertEqual(1, count);

    //Create another entity a long way away to check it's not destroyed by tracking (because it's not set to be tracked).
    e = _entity.create(SlotPosition(100, 100));
    count = _test.entityManager.getEntityCount();
    _test.assertEqual(2, count);

    //Make sure there are no tracked entities.
    _test.assertEqual(0, _test.entityManager.getTrackedEntityCount());

    _test.endTest();
}
