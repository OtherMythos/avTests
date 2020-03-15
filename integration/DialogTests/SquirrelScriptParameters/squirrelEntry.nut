//A test which tries to load and execute a squirrel script from the dialog system.
//This includes testing support for script call variables with both the local and global registry, as well as just plain constants.

function start(){
    ::currentString <- "";

    _registry.set("globalInt", 10);
    _registry.set("globalFloat", 12.45);
    _registry.set("globalBool", false);
    _registry.set("globalString", "a string");

    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/dialog/scriptDialog.dialog");

    {
        _dialogSystem.executeCompiledDialog(dialog, 0);

        _dialogSystem.registry.set("localInt", 20);
        _dialogSystem.registry.set("localFloat", 45.12);
        _dialogSystem.registry.set("localBool", true);
        _dialogSystem.registry.set("localString", "local string");

        _dialogSystem.update();
    }

    _test.endTest();
}

function update(){

}
