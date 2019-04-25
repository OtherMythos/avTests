//Check script reference counting by assigning it to a number of entities and then removing those entities.

function start(){
    _world.createWorld();

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    ::a <- _entity.create(SlotPosition());
    ::b <- _entity.create(SlotPosition());
    ::c <- _entity.create(SlotPosition());
    ::d <- _entity.create(SlotPosition());
    ::e <- _entity.create(SlotPosition());

    foreach(i in [a, b, c, d, e]){
        _component.mesh.add(i, "ogrehead2.mesh");
    }

    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 0);
}

function update(){
    //Assign the script, a new script will be designated.
    _component.script.add(a, _settings.getDataDirectory() + "/EntityScript.nut");
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);

    //Now do the same for the other entites.
    foreach(i in [b, c, d, e]){
        _component.script.add(i, _settings.getDataDirectory() + "/EntityScript.nut");
    }
    //The number of loaded scripts should stay the same, as the same script is shared between them.
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);

    //Now remove the component from all the entities.
    foreach(i in [a, b, c, d, e]){
        _component.script.remove(i);
    }
    //The script should be unloaded now as no entities reference it.
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 0);


    //Assign a script to an entity and check the script is loaded.
    _component.script.add(a, _settings.getDataDirectory() + "/EntityScript.nut");
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);
    //Now destroy the entity and see that the script is removed, as the reference count reaches 0.
    _entity.destroy(a);
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 0);

    //Assign this script to two entities and destroy one. The script should remain.
    _component.script.add(b, _settings.getDataDirectory() + "/EntityScript.nut");
    _component.script.add(c, _settings.getDataDirectory() + "/EntityScript.nut");
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);
    _entity.destroy(b);
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);
    _entity.destroy(c);
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 0);

    //Assign two different scripts to two different entities.
    _component.script.add(d, _settings.getDataDirectory() + "/EntityScript.nut");
    _component.script.add(e, _settings.getDataDirectory() + "/SecondScript.nut");
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 2);

    //Now check that unloading causes them to be destroyed.
    _entity.destroy(d);
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);
    _entity.destroy(e);
    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 0);


    _test.endTest();

}
