//A test which tries to load and execute a squirrel script from the dialog system.

function start(){
    ::currentString <- "";

    local dialog = _dialogSystem.compileDialog(_settings.getDataDirectory() + "/dialog/scriptDialog.dialog");

    {
        _dialogSystem.executeCompiledDialog(dialog, 0);
        _dialogSystem.update();
    }

    _test.endTest();
}

function update(){

}
