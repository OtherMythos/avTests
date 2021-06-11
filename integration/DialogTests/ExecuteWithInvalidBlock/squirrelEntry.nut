//A test to check that the engine properly handles running a compiled dialog with incorrect datablock.

function start(){
    local dialog = _dialogSystem.compileDialog("res://Dialog.dialog");

    local failed = false;
    try{
        //10 is invalid
        _dialogSystem.executeCompiledDialog(dialog, 10);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    _test.endTest();
}

function update(){

}
