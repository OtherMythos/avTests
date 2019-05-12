//A test to check that GetAvailableSaves returns a filled array with all available saves.

function start(){
    _world.createWorld();

    _serialisation.clearAllSaves();
    _test.assertTrue(_settings.getSaveDirectoryViable());

    ::stage <- 0
}

function update(){
    if(stage == 0){
        local saves = _serialisation.getAvailableSaves();
        _test.assertEqual(saves.len(), 0);
        stage++;
    }
    if(stage == 1){
        //I can't guarantee what the final format of the save is going to look like.
        //Therefore I need to create my own as part of the test.

        _world.createWorld();

        //Put some stuff in the world.
        local en = _entity.create(SlotPosition());
        _component.mesh.add(en, "ogrehead2.mesh");

        local handle = SaveHandle();
        handle.saveName = "firstSave";
        _world.serialise(handle);

        stage++;
    }
    if(stage == 2){
        if(_world.ready()) stage++;
    }
    if(stage == 3){
        //Now check this created save can be found.
        local saves = _serialisation.getAvailableSaves();
        _test.assertEqual(saves.len(), 1);

        _test.assertEqual(saves[0].saveName, "firstSave");
        stage++;
    }
    if(stage == 4){
        //Create another save and confirm it shows both.
        local handle = SaveHandle();
        handle.saveName = "secondSave";
        _world.serialise(handle);
        stage++;
    }
    if(stage == 5){
        if(_world.ready()) stage++;
    }
    if(stage == 6){
        local saves = _serialisation.getAvailableSaves();
        _test.assertEqual(saves.len(), 2);

        //There's no telling what the order will be, so I have to check like this.
        local names = [saves[0].saveName, saves[1].saveName];
        local firstSave, secondSave;
        firstSave = secondSave = false;
        foreach(i in names){
            if(i == "firstSave") firstSave = true;
            if(i == "secondSave") secondSave = true;
        }
        _test.assertTrue(firstSave);
        _test.assertTrue(secondSave);

        _serialisation.clearAllSaves();
        _test.endTest();
    }
}
