//A test to check that countdown timers can be added to call a certain function after a time period.

::target <- {
    "value": 23,

    function receiver(){
        //Check the context is correct.
        _test.assertEqual(this.value, 23);
        _test.endTest();
    }

    function invalidReceiver(first){

    }
};

function start(){
    _timer.countdown(100, target.receiver, target);

    local failed = false;
    try{
        _timer.countdown(100, target.invalidReceiver, target);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);
}
