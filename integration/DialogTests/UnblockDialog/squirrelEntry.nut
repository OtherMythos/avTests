//A test to check that unblocking the dialog advances it.

function start(){
    ::currentString <- "";

    _dialogSystem.compileAndRunDialog(_settings.getDataDirectory() + "/../../../Resources/dialog/SimpleDialog.dialog");


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

    //This will let it check that the end has been reached.
    _dialogSystem.update();

    _test.assertFalse(_dialogSystem.isDialogExecuting());

    _test.endTest();
}

function update(){

}
