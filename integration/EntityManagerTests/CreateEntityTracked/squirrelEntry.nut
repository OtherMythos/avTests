//Test tracked entity creation by creating some that should be destroyed and some that shouldn't.

function start(){
    _world.createWorld();

    _world.setPlayerPosition(SlotPosition());
    _world.setPlayerLoadRadius(100);
}

function update(){
    //This one is within the player radius, so should be created.
    local e = _entity.createTracked(SlotPosition());
    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _test.assertEqual(1, _test.entityManager.getTrackedEntityCount());
    _test.assertTrue(e.valid());

    //Now create an entity which is out of the tracking bounds. It should not even be created.
    local b = _entity.createTracked(SlotPosition(3, 3));
    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _test.assertEqual(1, _test.entityManager.getTrackedEntityCount());
    _test.assertFalse(b.valid());

    //Make the player load radius big enough to now accept that entity.
    _world.setPlayerLoadRadius(500);

    local c = _entity.createTracked(SlotPosition(3, 3));
    _test.assertEqual(2, _test.entityManager.getEntityCount());
    _test.assertEqual(2, _test.entityManager.getTrackedEntityCount());
    _test.assertTrue(c.valid());

    //Create a non-tracked entity and check that doesn't effect the tracked entity count.
    local c = _entity.create(SlotPosition());
    _test.assertEqual(2, _test.entityManager.getTrackedEntityCount());

    _test.endTest();
}
