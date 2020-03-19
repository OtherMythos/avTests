//A test to check that variables can be set in the dialog system.

function start(){
    /* ::currentString <- "";
    ::currentActorDirection <- [a, d]; */
    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/Dialog.dialog");

    //Set a value that doesn't exist at all.
    {
        _test.assertEqual(_registry.getInt("missingInt"), null);
        _test.assertEqual(_registry.getFloat("missingFloat"), null);
        _test.assertEqual(_registry.getBool("missingBool"), null);
        _test.assertEqual(_registry.getString("missingString"), null);
        _dialogSystem.executeCompiledDialog(dialog, 0);
        _dialogSystem.update();

        //Check these values are now there.
        _test.assertEqual(_registry.getInt("missingInt"), 10);
        _test.assertEqual(_registry.getFloat("missingFloat"), 10.1234);
        _test.assertEqual(_registry.getBool("missingBool"), false);
        _test.assertEqual(_registry.getString("missingString"), "someValue");
    }

    _test.endTest();
}
