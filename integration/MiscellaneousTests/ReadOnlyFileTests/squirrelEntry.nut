//A test to check that files can be opened with specific access modes,
//and that operations incompatible with the chosen mode fail.

//Helper which returns true if the passed function threw an error.
function expectThrow(func){
    local threw = false;
    try{
        func();
    }catch(e){
        threw = true;
    }
    return threw;
}

function testConstantsExist(){
    _test.assertEqual(typeof(_FILE_READ), "integer");
    _test.assertEqual(typeof(_FILE_WRITE), "integer");
    _test.assertEqual(typeof(_FILE_READ_WRITE), "integer");

    //They should be distinct values.
    _test.assertNotEqual(_FILE_READ, _FILE_WRITE);
    _test.assertNotEqual(_FILE_READ, _FILE_READ_WRITE);
    _test.assertNotEqual(_FILE_WRITE, _FILE_READ_WRITE);
}

function testReadOnly(){
    local file = File();
    file.open("res://testFile/testFile.txt", _FILE_READ);

    //Reading should still work.
    _test.assertEqual(file.getLine(), "This is some text");

    //Writing to a read only file should fail.
    _test.assertTrue(expectThrow(function(){
        file.write("some data");
    }));
    _test.assertTrue(expectThrow(function(){
        file.writeLine("some data");
    }));

    //Opening a non existent file for reading should fail.
    _test.assertTrue(expectThrow(function(){
        file.open("res://fileWhichDoesNotExist.txt", _FILE_READ);
    }));
}

function testWriteOnly(){
    local path = "/tmp/avWriteOnlyFileTest.txt";

    local file = File();
    file.open(path, _FILE_WRITE);

    //Writing should work.
    file.writeLine("written line");

    //Reading from a write only file should fail.
    _test.assertTrue(expectThrow(function(){
        file.getLine();
    }));
    file.close();

    //Read the file back in read mode to confirm the write actually happened.
    local verify = File();
    verify.open(path, _FILE_READ);
    _test.assertEqual(verify.getLine(), "written line");
    verify.close();
}

function testReadWrite(){
    local path = "/tmp/avReadWriteFileTest.txt";

    //Read write mode opens with in|out, which requires the file to exist,
    //so create it first with a write only handle.
    local creator = File();
    creator.open(path, _FILE_WRITE);
    creator.writeLine("read write line");
    creator.close();

    //Explicit read write mode should permit both reading and writing.
    local file = File();
    file.open(path, _FILE_READ_WRITE);
    _test.assertEqual(file.getLine(), "read write line");
    _test.assertFalse(expectThrow(function(){
        file.write("more");
    }));
    file.close();

    //The default mode (no argument) should remain read write for api compatibility.
    local defaultFile = File();
    defaultFile.open(path);
    _test.assertEqual(defaultFile.getLine(), "read write line");
    defaultFile.close();
}

function start(){
    testConstantsExist();
    testReadOnly();
    testWriteOnly();
    testReadWrite();

    _test.endTest();
}
