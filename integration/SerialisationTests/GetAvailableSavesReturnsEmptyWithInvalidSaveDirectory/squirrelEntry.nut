//A test to check that GetAvailableSaves returns an empty array when the save directory isn't viable.

function start(){
    _world.createWorld();

    _test.assertFalse(_settings.getSaveDirectoryViable());
}

function update(){
    local saves = _serialisation.getAvailableSaves();
    _test.assertEqual(saves.len(), 0);

    _test.endTest();
}
