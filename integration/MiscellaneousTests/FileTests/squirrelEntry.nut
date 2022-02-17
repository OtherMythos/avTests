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

    //Test where invalid args are passed to the api.
    file = File("a path");
    file.getLine();
    file.close();
    file.eof();

    file.getLine(10, false, "hello");
    file.close(10, false, "hello");
    file.eof(10, false, "hello");

    //Now do it properly with the same object
    file.open("res://testFile/testFile.txt");
    local string = file.getLine();
    _test.assertEqual(string, expected[0]);

    _test.endTest();
}
