//Test destroying of entities.

function start(){
}

function update(){
    local e = _entity.create(Vec3());

    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _entity.destroy(e);
    _test.assertEqual(0, _test.entityManager.getEntityCount());
    _test.assertFalse(e.valid());

    local d = _entity.create(Vec3());
    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _entity.destroy(d);
    _test.assertEqual(0, _test.entityManager.getEntityCount());
    _test.assertFalse(d.valid());

    _test.endTest();
}
