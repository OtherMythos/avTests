//A test to check that local variables appear in dialog strings correctly.

function start(){
    ::currentString <- "";
    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/Dialog.dialog");

    local expectedValues = [
        "first ",
        "second ",
        "third ",
        "fourth "
    ];
    local varValue = "variable";
    _dialogSystem.registry.set("varName", varValue);

    _dialogSystem.executeCompiledDialog(dialog, 0);
    for(local i = 0; i < 4; i++){
        _dialogSystem.update();

        _test.assertEqual(expectedValues[i] + varValue, ::currentString);

        print(currentString);
        _test.assertTrue(_dialogSystem.isDialogBlocked());
        _dialogSystem.unblock();
    }

    //This will let it check that the end has been reached.
    _dialogSystem.update();

    _test.assertFalse(_dialogSystem.isDialogExecuting());

    //By this point the dialog is ended, so the variable should be removed.
    _test.assertEqual(null, _dialogSystem.registry.get("varName"));

    { //Combination of local and global variables.
        _registry.set("first", 10);
        _registry.set("third", 30);
        _dialogSystem.registry.set("second", 20);
        _dialogSystem.registry.set("fourth", 40);
        _dialogSystem.executeCompiledDialog(dialog, 1);
        _dialogSystem.update();
        _test.assertEqual("dialogString 10 20 30 40", ::currentString);

        //Make it finish the dialog to check the variables are reset.
        _dialogSystem.unblock();
        _dialogSystem.update();

        _test.assertEqual(null, _dialogSystem.registry.get("second"));
        _test.assertEqual(null, _dialogSystem.registry.get("fourth"));
    }

    _test.endTest();
}
