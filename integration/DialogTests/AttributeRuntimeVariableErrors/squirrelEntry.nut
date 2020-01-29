//Checks and verifies that dialog tag attributes are handled correctly with runtime errors.

function start(){
    ::currentString <- "";
    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/Dialog.dialog");

    {
        local vals = ["something", 10.10002, false, null];

        foreach(i in vals){
            _registry.set("targetJmpBlock", i);
            _dialogSystem.executeCompiledDialog(dialog, 0);
            _dialogSystem.update();
            _test.assertEqual("", ::currentString);
            _test.assertFalse(_dialogSystem.isDialogExecuting());
        }
    }

    _test.endTest();
}
