//A test to check that events can be unsubscribed from.

::USER_EVENT <- 1001;

function userEventCallback(id, data){
    _test.assertEqual(id, ::USER_EVENT);
    ::eventCount++;
}

function start(){
    _event.subscribe(::USER_EVENT, userEventCallback);

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
        _event.unsubscribe(::USER_EVENT, userEventCallback);
        _event.transmit(::USER_EVENT, null);
        stage++;
    }
    else if(stage == 2){
        //Skip a frame to wait for it
        stage++;
    }
    else if(stage == 3){
        //The amount should not have been increased because of the unsubscribe.
        _test.assertEqual(::eventCount, 1);
        _event.subscribe(::USER_EVENT, userEventCallback);
        _event.transmit(::USER_EVENT, null);
        stage++;
    }
    else if(stage == 4){
        _test.assertEqual(::eventCount, 2);
        _test.endTest();
    }
}
