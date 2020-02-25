//A test which tries to load a squirrel script from the dialog system.
//TODO not actually complete at the moment.

function start(){
    ::currentString <- "";

    _dialogSystem.compileAndRunDialog(_settings.getDataDirectory() + "/dialog/scriptDialog.dialog");

    _test.endTest();
}

function update(){

}
