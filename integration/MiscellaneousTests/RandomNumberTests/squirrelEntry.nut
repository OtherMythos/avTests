//A test to check that the random number generation system works as expected.

function start(){
    for(local i = 0; i < 100; i++){
        local retVal = _random.rand();
        print(retVal);
        _test.assertTrue(retVal <= 1.0);
    }

    print("int range");
    for(local i = 0; i < 100; i++){
        local retVal = _random.randInt(5);
        print(retVal);
        _test.assertTrue(retVal <= 5 && retVal >= 0);
    }
    print("second range");
    for(local i = 0; i < 100; i++){
        local retVal = _random.randInt(5, 10);
        print(retVal);
        _test.assertTrue(retVal <= 10 && retVal >= 5);
    }

    print("negative range");
    for(local i = 0; i < 100; i++){
        local retVal = _random.randInt(-10, -5);
        print(retVal);
        _test.assertTrue(retVal <= -5 && retVal >= -10);
    }

    print("index of array");
    //Give it a small number to stress it out.
    local targetArray = array(10, null);
    for(local i = 0; i < 500; i++){
        local retVal = _random.randIndex(targetArray);
        print(retVal);
        _test.assertNotEqual(retVal, targetArray.len());
        _test.assertTrue(retVal < targetArray.len());
    }
    //Make sure it works with a min and max of 0-0
    local targetArray = array(1, null);
    for(local i = 0; i < 100; i++){
        local retVal = _random.randIndex(targetArray);
        print(retVal)
        _test.assertNotEqual(retVal, targetArray.len());
        _test.assertTrue(retVal < targetArray.len());
    }

    _test.endTest();
}
