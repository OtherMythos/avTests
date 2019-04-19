//Create an entity and move the player far enough so that the entity is destructed.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    _world.setPlayerPosition(SlotPosition());
    _world.setPlayerLoadRadius(50);

    //Create the entity
    ::e <- _entity.createTracked(SlotPosition());
    ::pos <- SlotPosition();
    _component.mesh.add(e, "ogrehead2.mesh");
    _test.assertEqual(1, _test.entityManager.getEntityCount());
    _test.assertEqual(1, _test.entityManager.getTrackedEntityCount());
    _test.assertTrue(e.valid());
}

function update(){
    pos.move(1, 0, 0);
    _world.setPlayerPosition(pos);

    local absPos = pos.toVector3();
    //The tracking system separates areas of the map into chunks.
    //Each chunk in this test is 100 units. If the player radius is 50, that means the player needs to move 150 units before the chunk will be unloaded.
    if(absPos[0] > 150){
        _test.assertFalse(e.valid());
        _test.assertEqual(0, _test.entityManager.getEntityCount());
        _test.assertEqual(0, _test.entityManager.getTrackedEntityCount());

        _test.endTest();
    }else{
        _test.assertTrue(e.valid());
    }
}
