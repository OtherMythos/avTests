//A test which checks custom user settings appear in the setup file.

function start(){

    local userInt = _settings.getUserSetting("userInt");
    _test.assertEqual(userInt, 100);

    local userFloat = _settings.getUserSetting("userFloat");
    _test.assertEqual(userFloat, 100.10);

    local userBool = _settings.getUserSetting("userBool");
    _test.assertEqual(userBool, true);

    local userBoolCase = _settings.getUserSetting("userBoolCase");
    _test.assertEqual(userBoolCase, false);

    local userString = _settings.getUserSetting("userString");
    _test.assertEqual(userString, "Some example text");

    local nullVal = _settings.getUserSetting("ValueThatDoesntExist");
    _test.assertEqual(nullVal, null);

    //A value which was placed in a different group in the config file.
    //All values end up in the same list.
    local secondSectionInt = _settings.getUserSetting("SecondSectionInt");
    _test.assertEqual(secondSectionInt, 300);

    _test.endTest();
}
