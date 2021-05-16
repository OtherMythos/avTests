//Test to check I can pause the entity update function.

function start(){
    _world.createWorld();

    ::updateCount <- 0;
    ::prevUpdateCount <- 0;
    ::stage <- 0;
    ::stageCount <- 0;

    _camera.setPosition(0, 100, 100);
    _camera.lookAt(0, 0, 0);

    ::e <- _entity.create(SlotPosition());

    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 0);

    _component.mesh.add(e, "ogrehead2.mesh");

    _component.script.add(e, "res://EntityScript.nut");

    _test.assertEqual(_test.entityManager.getLoadedCallbackScriptCount(), 1);
}

function update(){
    if(stage == 0){
        _test.assertTrue(::updateCount > 0);
        stageCount++;
        if(stageCount >= 20){
            _state.setPauseState(_PAUSE_ENTITY_UPDATE);
            ::prevUpdateCount = ::updateCount;
            stageCount = 0;
            stage++;
        }
    }
    else if(stage == 1){
        _test.assertEqual(prevUpdateCount, updateCount);
        stageCount++;
        if(stageCount >= 20){
            stage++;
            stageCount = 0;
            _state.setPauseState(0);
        }
    }
    else if(stage == 2){
        _test.assertNotEqual(prevUpdateCount, updateCount);
        stageCount++;
        if(stageCount >= 20){
            _test.endTest();
        }
    }
}
