//A test to check that countdown timers can be stopped mid way through.

::target <- {
    "value": 23,

    function receiver(){
        _test.endTest(false);
    }

    function invalidReceiver(first){

    }
};

function start(){
    ::targetId <- _timer.countdown(100, target.receiver, target);
    ::count <- 0;
}

function update(){
    ::count++;
    if(count == 15){
        _timer.cancelCountdown(::targetId);
    }
    else if(count >= 200){
        _test.endTest();
    }
}
