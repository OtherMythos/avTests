//Test the on-the-fly track and untrack capabilities by switching an entity between the states and seeing what happens.

function start(){
    _world.createWorld();

    _world.setPlayerPosition(SlotPosition());
    _world.setPlayerLoadRadius(100);
}

function update(){
    //Non tracked to start with
    local e = _entity.create(SlotPosition());
    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _test.assertTrue(e.trackable());

    _test.assertFalse(e.tracked());
    _test.assertEqual(0, _test.entityManager.getTrackedEntityCount());

    _entity.track(e);
    //The entity should still be valid, as it's within the bounds of the player radius.
    _test.assertTrue(e.valid());
    _test.assertTrue(e.tracked());
    _test.assertEqual(1, _test.entityManager.getTrackedEntityCount());

    //Untrack the entity and move it into a different place.
    _entity.untrack(e);
    _test.assertTrue(e.valid());
    _test.assertFalse(e.tracked());
    _test.assertEqual(0, _test.entityManager.getTrackedEntityCount());
    e.setPosition(SlotPosition(100, 100));
    //It should still be valid even though it's massively outside of the player radius, because it's not tracked.
    _test.assertTrue(e.valid());

    //If tracked now, the entity should be destroyed and invalidated.
    _entity.track(e);
    _test.assertFalse(e.valid());

    _test.assertEqual(0, _test.entityManager.getTrackedEntityCount());
    _test.assertEqual(0, _test.entityManager.getEntityCount());


    _test.endTest();
}
