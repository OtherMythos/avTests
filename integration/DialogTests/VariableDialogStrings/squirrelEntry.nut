//A test to check that variables appear in dialog strings correctly.

function start(){
    ::currentString <- "";
    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/Dialog.dialog");

    local typeValues = ["aValue", 10, false, ""];

    local expectedValues = [
        "first ",
        "second ",
        "third ",
        "fourth "
    ];
    foreach(y in typeValues){
        _registry.set("varName", y);

        _dialogSystem.executeCompiledDialog(dialog, 0);
        for(local i = 0; i < 4; i++){
            _dialogSystem.update();

            _test.assertEqual(expectedValues[i] + y, ::currentString);

            print(currentString);
            _test.assertTrue(_dialogSystem.isDialogBlocked());
            _dialogSystem.unblock();
        }
    }

    //This will let it check that the end has been reached.
    _dialogSystem.update();

    _test.assertFalse(_dialogSystem.isDialogExecuting());

    { //Check that multiple variables can be inserted into a single string.
        _registry.set("first", 10);
        _registry.set("second", 20);
        _registry.set("third", 30);
        _registry.set("fourth", 40);
        _dialogSystem.executeCompiledDialog(dialog, 1);
        _dialogSystem.update();
        _test.assertEqual("dialogString 10 20 30 40", ::currentString);

    }


    _test.endTest();
}

function update(){

}
