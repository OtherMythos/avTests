//A test to check that the option tag api triggers certain errors if called incorrectly.

function start(){
    ::currentString <- "";

    //xml is invalid so should fail.
    local failed = false;
    try{
        _dialogSystem.compileDialog("res://Dialog/broken.dialog");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    //An option tag without any contents.
    failed = false;
    try{
        _dialogSystem.compileDialog("res://Dialog/optionWithNoContents.dialog");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    //An option tag without any target
    failed = false;
    try{
        _dialogSystem.compileDialog("res://Dialog/optionWithNoTarget.dialog");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);


    //This one should work.
    local compiledDialog = _dialogSystem.compileDialog("res://Dialog/optionValid.dialog");
    _dialogSystem.executeCompiledDialog(compiledDialog);


    _dialogSystem.update();

    //Check the results of the dialog.
    _test.assertEqual(1, ::currentOptions.len());
    _test.assertTrue(::currentOptions[0] == "Some text.");

    _test.endTest();
}

function update(){

}
