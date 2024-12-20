//Check squirrel buffers can be compiled from strings.

function start(){
    ::test <- 10;

    //Ensure the buffer can be compiled and called.
    {
        _test.assertEqual(::test, 10);
        local buffer = "::test = 20";
        local buf = _compileBuffer(buffer);
        buf();
        _test.assertEqual(::test, 20);
    }

    //Ensure buffers which fail to compile throws an error.
    {
        local buffer = "soemthing{ other ; test";
        local failed = false;
        try{
            local buf = _compileBuffer(buffer);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    //Ensure buffers which contain broken code fail as normal.
    {
        local failed = false;
        local buffer = "::test = something";
        local buf = _compileBuffer(buffer);
        try{
            buf();
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    _test.endTest();
}