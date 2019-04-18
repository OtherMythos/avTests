//Create an entity and move it until it leaves the player radius, and is destroyed in the process.

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
    e.setPosition(pos);
    //The load radius is 50, which will intercept with the first chunk in the map.
    //So when it moves to the next chunk it should be unloaded.
    if(pos.slotX >= 1){
        _test.assertFalse(e.valid());

        _test.endTest();
    }else{
        _test.assertTrue(e.valid());
    }
}
