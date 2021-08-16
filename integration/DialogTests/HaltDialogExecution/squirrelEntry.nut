//A test to check that dialog can be halted early with jmp and option tags.

function start(){
    ::currentString <- "";

    local dialog = _dialogSystem.compileDialog("res://dialog/d.dialog");

    {
        _dialogSystem.executeCompiledDialog(dialog, 0);

        _dialogSystem.update();
        print(::currentString);
        _test.assertEqual(::currentString, "starting");

        _dialogSystem.unblock();
        _dialogSystem.update();

        //Should have ended when it saw the negative number.
        _test.assertFalse(_dialogSystem.isDialogExecuting());
    }

    {
        _dialogSystem.executeCompiledDialog(dialog, 1);

        _dialogSystem.update();
        print(::currentString);
        _test.assertEqual(::currentString, "starting options");

        _dialogSystem.unblock();
        _dialogSystem.update();

        //Should have reached the options.
        _test.assertTrue(_dialogSystem.isDialogBlocked());
        _test.assertEqual(::currentOptions.len(), 2);
        _test.assertEqual(::currentOptions[0], "first");
        _test.assertEqual(::currentOptions[1], "second");

        _dialogSystem.specifyOption(0);

        _test.assertFalse(_dialogSystem.isDialogExecuting());
    }

    _test.endTest();
}

function update(){

}
