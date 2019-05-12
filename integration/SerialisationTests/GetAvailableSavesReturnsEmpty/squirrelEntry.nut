//A test to check that GetAvailableSaves returns an empty array if there are no saves.

function start(){
    _world.createWorld();
}

function update(){
    _serialisation.clearAllSaves();
    _test.assertTrue(_settings.getSaveDirectoryViable());

    local saves = _serialisation.getAvailableSaves();
    _test.assertEqual(0, saves.len());

    _test.endTest();
}
