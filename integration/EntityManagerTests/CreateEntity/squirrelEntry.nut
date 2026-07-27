//Create an entity and check that the entity count in the entity manager goes up.

function start(){
}

function update(){
    local e = _entity.create(Vec3());

    local count = _test.entityManager.getEntityCount();
    _test.assertEqual(1, count);

    e = _entity.create(Vec3());
    count = _test.entityManager.getEntityCount();
    _test.assertEqual(2, count);


    _test.endTest();
}
