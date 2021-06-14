//A test to check that the random number generation system works as expected.

function start(){
    local file = File();

    local failed = false;
    try{
        file.open("res://fileWhichDoesNotExist.txt");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    file.open("res://testFile/testFile.txt");

    local expected = [
        "This is some text",
        "This is some more"
    ];
    foreach(i in expected){
        _test.assertTrue(i == file.getLine());
    }

    _test.endTest();
}
