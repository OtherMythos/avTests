//A test which tries to load and execute a squirrel script from the dialog system.

function start(){
    ::currentString <- "";
    ::currentCount <- 0;

    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/dialog/scriptDialog.dialog");

    {
        _dialogSystem.executeCompiledDialog(dialog, 0);
        _dialogSystem.update();
        _test.assertEqual(currentString, "first");
    }
    {
        _dialogSystem.executeCompiledDialog(dialog, 1);
        _dialogSystem.update();
        _test.assertEqual(currentString, "second");
    }
    {
        //Check that the sytem can run script tags one after the other without stopping.
        //Each entry in the list should be called once one after the other, increasing the count.
        _test.assertEqual(0, currentCount);
        _dialogSystem.executeCompiledDialog(dialog, 2);
        _dialogSystem.update();
        _test.assertEqual(currentCount, 2);
    }
    {
        ::currentString = "";
        _dialogSystem.executeCompiledDialog(dialog, 3);
        _dialogSystem.update();
        _test.assertEqual(currentString, "second file");
    }
    {
        ::currentString = "";
        _dialogSystem.executeCompiledDialog(dialog, 4);
        _dialogSystem.update();
        _test.assertEqual(currentString, "firstsecond");
    }

    _test.endTest();
}

function update(){

}
