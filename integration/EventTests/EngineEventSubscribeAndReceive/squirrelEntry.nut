//A test to check events can be subscribed to and received correctly.

::FIRST_EVENT <- 1001;
::SECOND_EVENT <- 1002;

function firstCallback(id, data){
    _test.assertEqual(id, ::FIRST_EVENT);
    _test.assertEqual(data, null); //The data for certain events will be null.
    ::firstCount++;
}

function secondCallback(id, data){
    _test.assertEqual(id, ::SECOND_EVENT);
    _test.assertEqual(data, null);
    ::secondCount++;
}

function start(){
    _event.subscribe(::FIRST_EVENT, firstCallback);
    _event.subscribe(::SECOND_EVENT, secondCallback);

    local errorFound = false;
    try{
        //Subscribing to null should throw an error.
        _event.subscribe(_EVENT_NULL, secondCallback);
    }catch(e){
        errorFound = true;
    }
    _test.assertTrue(errorFound);

    ::firstCount <- 0;
    ::secondCount <- 0;

    ::stage <- 0;
}

function update(){
    if(stage == 0){
        _event.transmit(::FIRST_EVENT, null);
        stage++;
    }
    else if(stage == 1){
        _test.assertEqual(::firstCount, 1);
        _event.transmit(::SECOND_EVENT, null);
        stage++;
    }
    else if(stage == 2){
        _test.assertEqual(::secondCount, 1);

        _test.endTest();
    }
}
