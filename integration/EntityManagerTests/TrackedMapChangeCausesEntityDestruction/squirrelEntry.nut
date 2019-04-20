//On map change, all tracked entities should be destroyed.
//This test creates tracked entities one one map, and changes the map, expecting all the created tracked entities to be destroyed.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    _slotManager.setCurrentMap("first");

    _world.setPlayerPosition(SlotPosition());
    _world.setPlayerLoadRadius(150);

    //Create entities in two different slots.
    ::e <- _entity.createTracked(SlotPosition(0, 0));
    _component.mesh.add(e, "ogrehead2.mesh");
    ::d <- _entity.createTracked(SlotPosition(1, 0));
    _component.mesh.add(d, "ogrehead2.mesh");
}

function update(){
    _test.assertEqual(2, _test.entityManager.getEntityCount());
    _test.assertEqual(2, _test.entityManager.getTrackedEntityCount());
    _test.assertTrue(e.valid());
    _test.assertTrue(d.valid());

    _slotManager.setCurrentMap("second");

    //Now the map has changed the entities should have been destroyed.
    _test.assertFalse(e.valid());
    _test.assertFalse(d.valid());
    _test.assertEqual(0, _test.entityManager.getEntityCount());
    _test.assertEqual(0, _test.entityManager.getTrackedEntityCount());

    _test.endTest();
}
