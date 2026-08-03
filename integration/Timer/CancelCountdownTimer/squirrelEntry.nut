//A test to check that countdown timers can be stopped mid way through.

::shortTarget <- {
    function receiver(){
        //Shorter timer was cancelled, so it should never fire.
        _test.endTest(false);
    }
};

::longTarget <- {
    function receiver(){
        _test.endTest();
    }
};

function start(){
    //Timer is in milliseconds.
    const TIME_MULT = 50;
    ::shortId <- _timer.countdown(1 * TIME_MULT, shortTarget.receiver, shortTarget);
    ::longId <- _timer.countdown(2 * TIME_MULT, longTarget.receiver, longTarget);
    ::count <- 0;
}

function update(){
    //Wait a few frames.
    if(count == 2){
        _timer.cancelCountdown(::shortId);
    }

    ::count++;
}
