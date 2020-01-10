//A test to check the squirrel compiled dialog objects.

function start(){
    ::currentString <- "";

    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/../../../Resources/dialog/SimpleDialog.dialog");
    _dialogSystem.executeCompiledDialog(dialog); //Defaults to 0.


    local expectedValues = [
        "first",
        "second",
        "third",
        "fourth"
    ];
    for(local i = 0; i < 4; i++){
        _dialogSystem.update();

        _test.assertEqual(expectedValues[i], ::currentString);

        print(currentString);
        _test.assertTrue(_dialogSystem.isDialogBlocked());
        _dialogSystem.unblock();
    }

    _dialogSystem.update();

    _test.assertFalse(_dialogSystem.isDialogExecuting());

    //Up until now that was entirely the same as the other test.
    _dialogSystem.executeCompiledDialog(dialog, 1); //Execute dialog block 1.
    for(local i = 0; i < 4; i++){
        _dialogSystem.update();

        _test.assertEqual(expectedValues[i] + i.tostring(), ::currentString);

        print(currentString);
        _test.assertTrue(_dialogSystem.isDialogBlocked());
        _dialogSystem.unblock();
    }

    _test.endTest();
}

function update(){

}
