//Check that multiple setup files can be used.
//Files can be parsed through the command line, or using the avSetupSecondary.cfg file.
//avSetupSecondary.cfg is generally expected to be used for gitignore local flags, but in this case still tests multiple setup files.

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