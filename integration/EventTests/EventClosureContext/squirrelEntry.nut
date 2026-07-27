//A test to check contexts can be applied to called functions.

::USER_EVENT <- 1001;

::targetTable <- {
    "value": 10,

    "userEventCallback": function(id, data){
        _test.assertEqual(id, ::USER_EVENT);
        _test.assertTrue("value" in this);
        ::eventCount++;
    }
}

function start(){
    _event.subscribe(::USER_EVENT, targetTable.userEventCallback, targetTable);

    ::eventCount <- 0;

    ::stage <- 0;
}

function update(){
    if(stage == 0){
        _event.transmit(::USER_EVENT, null);
        stage++;
    }
    else if(stage == 1){
        _test.assertEqual(::eventCount, 1);
        //Ensure if the table is deleted, the callback can still be called correctly.
        ::targetTable = null;
        _event.transmit(::USER_EVENT, null);
        stage++;
    }
    else if(stage == 2){
        _test.assertEqual(::eventCount, 2);
        _test.endTest();
    }
}
