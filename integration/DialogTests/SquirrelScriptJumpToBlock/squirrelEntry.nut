//A test which tries to load and execute a squirrel script from the dialog system.
//This includes testing support for script call variables with both the local and global registry, as well as just plain constants.

function start(){
    ::currentString <- "";

    local dialog = _dialogSystem.compileDialog("res://dialog/scriptDialog.dialog");

    ::retVal <- true;
    {
        _dialogSystem.executeCompiledDialog(dialog, 0);
        _dialogSystem.update();
        _test.assertEqual(::currentString, "testValue1");
    }

    ::retVal = false;
    {
        _dialogSystem.executeCompiledDialog(dialog, 0);
        _dialogSystem.update();
        _test.assertEqual(::currentString, "testValueFirst");
    }

    ::retVal = true;
    {
        _registry.set("funcName", "second");
        _registry.set("blockId", 2);
        _dialogSystem.executeCompiledDialog(dialog, 10);
        _dialogSystem.update();
        _test.assertEqual(::currentString, "testValue2");
    }

    ::retVal = true;
    {
        _registry.set("blockId", 3);
        _dialogSystem.executeCompiledDialog(dialog, 11);
        _dialogSystem.update();
        _test.assertEqual(::currentString, "testValue3");
    }

    ::retVal = true;
    {
        _registry.set("funcName", "second");
        _dialogSystem.executeCompiledDialog(dialog, 12);
        _dialogSystem.update();
        _test.assertEqual(::currentString, "testValue4");
    }

    _test.endTest();
}

function update(){

}
