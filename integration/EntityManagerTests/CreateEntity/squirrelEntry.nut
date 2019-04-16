//Create an entity and check that the entity count in the entity manager goes up.

function start(){
    _world.createWorld();
}

function update(){
    local e = _entity.create(SlotPosition());

    local count = _test.entityManager.getEntityCount();
    _test.assertEqual(1, count);

    //Create another entity for a laff
    e = _entity.create(SlotPosition());
    count = _test.entityManager.getEntityCount();
    _test.assertEqual(2, count);

    _test.endTest();
}
