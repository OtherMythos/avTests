//Test destroying of entities.

function start(){
    _world.createWorld();
}

function update(){
    local e = _entity.create(SlotPosition());

    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _entity.destroy(e);
    _test.assertEqual(0, _test.entityManager.getEntityCount());
    _test.assertFalse(e.valid());

    //Now test that if a tracked entity is destroyed, the number of tracked entities goes down as well.
    local d = _entity.createTracked(SlotPosition());
    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _test.assertEqual(1, _test.entityManager.getTrackedEntityCount());
    _entity.destroy(d);
    _test.assertEqual(0, _test.entityManager.getEntityCount());
    _test.assertEqual(0, _test.entityManager.getTrackedEntityCount());
    _test.assertFalse(d.valid());

    _test.endTest();
}
