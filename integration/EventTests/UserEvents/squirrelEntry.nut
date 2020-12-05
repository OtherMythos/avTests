//A test to check contexts can be applied to called functions.

const FIRST_EVENT = 1001;
const SECOND_EVENT = 1002;

::targetTable <- {
    "value": 0,
    "secondValue": 0,

    "firstCallback": function(id, data){
        _test.assertEqual(data, 10);
        this.value += data;
    },

    "secondCallback": function(id, data){
        _test.assertEqual(data, 10);
        this.secondValue += data;
    }
}

function start(){
    _event.subscribe(FIRST_EVENT, targetTable.firstCallback, targetTable);
    for(local i = 0; i < 10; i++){
        _test.assertEqual(::targetTable.value, i*10);
        _event.transmit(FIRST_EVENT, 10);
    }
    _event.unsubscribe(FIRST_EVENT, targetTable.firstCallback);
    //Should not be called.
    for(local i = 0; i < 10; i++){
        _event.transmit(FIRST_EVENT, 10);
    }
    _test.assertEqual(::targetTable.value, 100);

    //Multiple callback functions
    ::targetTable.value = 0;
    _event.subscribe(FIRST_EVENT, targetTable.firstCallback, targetTable);
    _event.subscribe(FIRST_EVENT, targetTable.secondCallback, targetTable);
    for(local i = 0; i < 10; i++){
        _test.assertEqual(::targetTable.value, i*10);
        _test.assertEqual(::targetTable.secondValue, i*10);
        _event.transmit(FIRST_EVENT, 10);
    }
    _event.unsubscribe(FIRST_EVENT, targetTable.firstCallback);
    _event.unsubscribe(FIRST_EVENT, targetTable.secondCallback);

    local errorThrown = false;
    try{
        //Trying to unsubscribe something that doesn't exist.
        _event.unsubscribe(FIRST_EVENT, targetTable.secondCallback);
    }catch(e){
        errorThrown = true;
    }
    _test.assertTrue(errorThrown);

    _test.endTest();
}
