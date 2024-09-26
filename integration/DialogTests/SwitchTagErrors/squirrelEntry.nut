//A test to check that switch tags error as expected

function start(){

    local paths = [
        "res://Dialog/broken.dialog",
        "res://Dialog/switchWithNoContents.dialog",
        "res://Dialog/switchWithNoContents.dialog",
        "res://Dialog/switchWithNoTarget.dialog",
        "res://Dialog/switchWithNoTest.dialog",
        "res://Dialog/switchWithInvalidTag.dialog",
    ];

    foreach(i in paths){
        local failed = false;
        try{
            _dialogSystem.compileDialog(i);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    _test.endTest();

}
