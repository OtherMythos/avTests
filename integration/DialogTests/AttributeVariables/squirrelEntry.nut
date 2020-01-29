//A test to check that local and global variables can be correctly assigned to tag attributes.

function start(){
    ::currentString <- "";
    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/Dialog.dialog");

    {
        _registry.set("targetJmpBlock", 1);
        _dialogSystem.executeCompiledDialog(dialog, 0);
        _dialogSystem.update();
        _test.assertEqual("Block 1", ::currentString);
        _dialogSystem.unblock();
    }
    {
        _registry.set("targetJmpBlock", 2);
        _dialogSystem.executeCompiledDialog(dialog, 0);
        _dialogSystem.update();
        _test.assertEqual("Block 2", ::currentString);
        _dialogSystem.unblock();
    }

    {
        _dialogSystem.registry.set("targetJmpBlock", 1);
        _dialogSystem.executeCompiledDialog(dialog, 3);
        _dialogSystem.update();
        _test.assertEqual("Block 1", ::currentString);
        _dialogSystem.unblock();
    }
    {
        _dialogSystem.registry.set("targetJmpBlock", 2);
        _dialogSystem.executeCompiledDialog(dialog, 3);
        _dialogSystem.update();
        _test.assertEqual("Block 2", ::currentString);
        _dialogSystem.unblock();
    }

    _test.endTest();
}
