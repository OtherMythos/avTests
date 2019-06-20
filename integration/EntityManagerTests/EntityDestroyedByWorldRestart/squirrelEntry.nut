//Create a world, create an entity, check it's valid, destroy the world, check the entity is invalid.
//When another world is created the entity should still be invalid.

function start(){
    _world.createWorld();
}

function update(){
    local e = _entity.create(SlotPosition());

    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _test.assertTrue(e.valid());

    _world.destroyWorld();
    _test.assertFalse(e.valid());

    _world.createWorld();
    //Should still be false.
    _test.assertFalse(e.valid());
    _test.assertEqual(0, _test.entityManager.getEntityCount());

    _test.endTest();
}
