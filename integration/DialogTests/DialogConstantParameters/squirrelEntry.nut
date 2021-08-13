//A test to check that constants can be applied to parameters in dialog scripts.

function start(){

    local compiledDialog = _dialogSystem.compileDialog("res://Dialog/d.dialog");
    {
        _registry.set("varInt", 200);
        _registry.set("varFloat", 300.123);
        _registry.set("varBool", true);
        _registry.set("varString", "untaintedString");

        _dialogSystem.executeCompiledDialog(compiledDialog, 0);

        _dialogSystem.update();

        _test.assertEqual(_registry.get("varInt"), 10);
        _test.assertEqual(_registry.get("varFloat"), 20.24);
        _test.assertEqual(_registry.get("varBool"), false);
        _test.assertEqual(_registry.get("varString"), "stringVal");

        _test.endTest();
    }

}

function update(){

}

