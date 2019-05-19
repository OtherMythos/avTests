//A test to check that GetAvailableSaves returns an empty array if there are no saves.

function start(){
    _world.createWorld();

    _test.serialisation.assureSaveDirectory();
    _test.assertTrue(_settings.getSaveDirectoryViable());
}

function update(){
    _serialisation.clearAllSaves();

    local saves = _serialisation.getAvailableSaves();
    _test.assertEqual(0, saves.len());

    _test.endTest();
}
