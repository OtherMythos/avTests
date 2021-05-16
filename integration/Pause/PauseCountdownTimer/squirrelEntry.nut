//Checks that countdown timers can be paused midway through.

::target <- {
    "value": 23,

    function receiver(){
        //Check the context is correct.
        _test.assertEqual(this.value, 23);
        _test.endTest(count > 200);
    }

    function invalidReceiver(first){

    }
};

function pauseCountdown(){
    print("pausing countdown");
    _state.setPauseState(_PAUSE_TIMERS);
}

function start(){
    ::count <- 0;

    _timer.countdown(100, target.receiver, target);
    _timer.countdown(50, pauseCountdown);

    local failed = false;
    try{
        _timer.countdown(100, target.invalidReceiver, target);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);
}

function update(){
    ::count++;
    if(count == 200) _state.setPauseState(0);
    //The timeout will catch if the timer does not restart.
}
