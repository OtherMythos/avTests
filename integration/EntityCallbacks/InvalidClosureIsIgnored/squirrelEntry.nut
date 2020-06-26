//Check that invalid closures assigned to entities are not used.
//For instance, a closure with the wrong number of parameters should be ignored.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    ::e <- _entity.create(SlotPosition());

    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 0);

    _component.mesh.add(e, "ogrehead2.mesh");
    _component.script.add(e, _settings.getDataDirectory() + "/EntityScript.nut");

    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);

    ::movementCount <- 0;
    ::destroyedCount <- 0;
}

function update(){
    //Now when the entity is moved, the 'moved' callback should be executed, increasing the root table count.
    //However, as the moved callback is not valid, the move count should not be increased.

    _test.assertEqual(movementCount, 0);

    for(local i = 0; i < 10; i++){
        e.move(1, 0, 0);
        _test.assertEqual(movementCount, 0);
    }

    //Now when the entity is destroyed, the 'destroyed' callback should be run.
    _test.assertEqual(destroyedCount, 0);

    _entity.destroy(e);

    _test.assertEqual(destroyedCount, 1);
    //If the entity is destroyed the script should be removed.
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 0);

    _test.endTest();
}
