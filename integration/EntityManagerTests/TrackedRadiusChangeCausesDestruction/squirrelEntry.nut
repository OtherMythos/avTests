//Create a tracked entity and then change the player load radius. Doing this should cause the enity to be destructed.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    _world.setPlayerPosition(SlotPosition());
    _world.setPlayerLoadRadius(150);

    //Create the entity
    ::e <- _entity.createTracked(SlotPosition(1, 0));
    _component.mesh.add(e, "ogrehead2.mesh");
    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _test.assertEqual(1, _test.entityManager.getTrackedEntityCount());
    _test.assertTrue(e.valid());
}

function update(){
    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _test.assertEqual(1, _test.entityManager.getTrackedEntityCount());
    _test.assertTrue(e.valid());

    _world.setPlayerLoadRadius(50);

    //Now the radius has changed that entire chunk falls outside, and should have been destroyed.
    _test.assertFalse(e.valid());
    _test.assertEqual(0, _test.entityManager.getEntityCount());
    _test.assertEqual(0, _test.entityManager.getTrackedEntityCount());

    _test.endTest();
}
