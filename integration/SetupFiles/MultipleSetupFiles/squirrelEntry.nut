//Check that multiple setup files can be used.

function start(){

    local first = _settings.getUserSetting("first");
    _test.assertEqual(first, 200);
    local second = _settings.getUserSetting("second");
    _test.assertEqual(second, "secondvalue");

    //Defined only in the second setup file.
    local unique = _settings.getUserSetting("unique");
    _test.assertEqual(unique, false);

    _test.endTest();
}