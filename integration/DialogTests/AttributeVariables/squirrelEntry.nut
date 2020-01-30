//A test to check that local and global variables can be correctly assigned to tag attributes.

function compareArrays(a, b){
    _test.assertEqual(a.len(), b.len());

    for(local i = 0; i < a.len(); i++){
        _test.assertEqual(a[i], b[i]);
    }
}

function start(){
    /* ::currentString <- "";
    ::currentActorDirection <- [a, d]; */
    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/Dialog.dialog");

    //jmp
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

    //Actor change direction
    {
        _dialogSystem.executeCompiledDialog(dialog, 4);
        _dialogSystem.update();
        compareArrays([0, 10], ::currentActorDirection);
    }
    {
        _registry.set("targetActor", 5);
        _registry.set("targetActorDirection", 13);
        _dialogSystem.executeCompiledDialog(dialog, 5);
        _dialogSystem.update();
        compareArrays([5, 13], ::currentActorDirection);
        //Delete these values
        _registry.set("targetActor", null);
        _registry.set("targetActorDirection", null);
    }
    {
        _dialogSystem.registry.set("targetActor", 10);
        _dialogSystem.registry.set("targetActorDirection", 134);
        _dialogSystem.executeCompiledDialog(dialog, 6);
        _dialogSystem.update();
        compareArrays([10, 134], ::currentActorDirection);
    }
    { //Include a single constant with the variables.
        _dialogSystem.registry.set("targetActorDirection", 155);
        _dialogSystem.executeCompiledDialog(dialog, 7);
        _dialogSystem.update();
        compareArrays([30, 155], ::currentActorDirection);
    }

    //Actor move to
    {
        _dialogSystem.executeCompiledDialog(dialog, 8);
        _dialogSystem.update();
        compareArrays([1, 10, 20, 30], ::currentActorMoveTo);
    }
    {
        _registry.set("aId", 5);
        _registry.set("x", 10);
        _registry.set("y", 20);
        _registry.set("z", 30);
        _dialogSystem.executeCompiledDialog(dialog, 9);
        _dialogSystem.update();
        compareArrays([5, 10, 20, 30], ::currentActorMoveTo);
        _registry.set("aId", null);
        _registry.set("x", null);
        _registry.set("y", null);
        _registry.set("z", null);
    }
    {
        _dialogSystem.registry.set("aId", 5);
        _dialogSystem.registry.set("x", 10);
        _dialogSystem.registry.set("y", 20);
        _dialogSystem.registry.set("z", 30);
        _dialogSystem.executeCompiledDialog(dialog, 10);
        _dialogSystem.update();
        compareArrays([5, 10, 20, 30], ::currentActorMoveTo);
    }
    {
        _registry.set("aId", 15);
        _dialogSystem.registry.set("x", 10);
        _registry.set("y", 25);
        _dialogSystem.registry.set("z", 30);
        _dialogSystem.executeCompiledDialog(dialog, 11);
        _dialogSystem.update();
        compareArrays([15, 10, 25, 30], ::currentActorMoveTo);
        _registry.set("aId", null);
        _registry.set("y", null);
    }

    _test.endTest();
}
