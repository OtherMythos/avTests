//A test to check that switch tags work as expected.

function start(){

    local compiledDialog = _dialogSystem.compileDialog("res://Dialog/d.dialog");
    {
        _dialogSystem.executeCompiledDialog(compiledDialog, 0);
        _dialogSystem.update();

        _test.assertEqual(::currentString, "testCase1");
    }

    {
        _registry.set("firstBlock", 0);
        _registry.set("secondBlock", 3);
        _registry.set("thirdBlock", 0);
        _registry.set("fourthBlock", 0);

        _registry.set("testCaseFirst", false);
        _registry.set("testCaseSecond", true);
        _registry.set("testCaseThird", false);
        _registry.set("testCaseFourth", false);

        _dialogSystem.executeCompiledDialog(compiledDialog, 1);
        _dialogSystem.update();

        _test.assertEqual(::currentString, "testCase2");
    }

    {
        _registry.set("firstBlock", 0);
        _registry.set("secondBlock", 0);
        _registry.set("thirdBlock", 0);
        _registry.set("fourthBlock", 4);

        _registry.set("testCaseFirst", false);
        _registry.set("testCaseSecond", false);
        _registry.set("testCaseThird", false);
        _registry.set("testCaseFourth", true);

        _dialogSystem.executeCompiledDialog(compiledDialog, 1);
        _dialogSystem.update();

        _test.assertEqual(::currentString, "testCase3");
    }

    {
        _registry.set("firstBlock", 0);
        _registry.set("secondBlock", 3);
        _registry.set("thirdBlock", 0);
        _registry.set("fourthBlock", 4);

        _registry.set("testCaseFirst", false);
        _registry.set("testCaseSecond", true);
        _registry.set("testCaseThird", false);
        _registry.set("testCaseFourth", true);

        _dialogSystem.executeCompiledDialog(compiledDialog, 1);
        _dialogSystem.update();

        _test.assertEqual(::currentString, "testCase2");
    }

    {
        _registry.set("firstBlock", 0);
        _registry.set("secondBlock", 3);

        _registry.set("testCaseFirst", false);
        _registry.set("testCaseSecond", true);

        _dialogSystem.executeCompiledDialog(compiledDialog, 20);
        _dialogSystem.update();

        _test.assertEqual(::currentString, "testCase2");

        //Change the value it points to for good measure.
        _registry.set("secondBlock", 4);
        _dialogSystem.executeCompiledDialog(compiledDialog, 20);
        _dialogSystem.update();

        _test.assertEqual(::currentString, "testCase3");
    }

    {
        _registry.set("firstBlock", 2);
        _registry.set("secondBlock", 3);

        _dialogSystem.executeCompiledDialog(compiledDialog, 30);
        _dialogSystem.update();

        _test.assertEqual(::currentString, "testCase2");
    }

    _test.endTest();

}

function update(){

}
