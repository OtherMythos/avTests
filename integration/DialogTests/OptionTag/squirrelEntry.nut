//A test to check that option tags work as expected.

function start(){

    local compiledDialog = _dialogSystem.compileDialog("res://Dialog/d.dialog");
    {
        _dialogSystem.executeCompiledDialog(compiledDialog, 0);
        _dialogSystem.update();

        //Check the results of the dialog.
        _test.assertEqual(4, ::currentOptions.len());
        _test.assertTrue(::currentOptions[0] == "first");
        _test.assertTrue(::currentOptions[1] == "second");
        _test.assertTrue(::currentOptions[2] == "third");
        _test.assertTrue(::currentOptions[3] == "fourth");

        _dialogSystem.specifyOption(1);

        _dialogSystem.update();

        _test.assertEqual(::currentString, "Block 2");
    }

    {
        _registry.set("firstBlock", 5);
        _registry.set("secondBlock", 10);
        _registry.set("thirdBlock", 20);
        _registry.set("fourthBlock", 30);

        _dialogSystem.executeCompiledDialog(compiledDialog, 1);
        _dialogSystem.update();

        _test.assertEqual(4, ::currentOptions.len());
        _test.assertTrue(::currentOptions[0] == "firstReg");
        _test.assertTrue(::currentOptions[1] == "secondReg");
        _test.assertTrue(::currentOptions[2] == "thirdReg");
        _test.assertTrue(::currentOptions[3] == "fourthReg");

        //Ask to go to whatever block 'second' points to.
        _dialogSystem.specifyOption(1);

        _dialogSystem.update();

        //Check the results of the dialog.
        _test.assertEqual(4, ::currentOptions.len());
        //Should have jumped to block 10.
        _test.assertEqual(::currentString, "Block 10");

        _test.endTest();
    }

}

function update(){

}
