//Checks that a worker's vm survives between dispatches, and that what comes back is a copy rather
//than a reference into the worker's own state.

function start(){
    ::w <- _worker.create("res://worker.nut");

    ::expected <- [5, 7, 11];
    ::index <- 0;
    ::runningTotal <- 0;
    ::firstHistory <- null;

    _test.assertTrue(::w.dispatch({ amount = ::expected[0] }));
}

function update(){
    if(::index >= ::expected.len()) return;
    if(::w.poll() != _WORKER_READY) return;

    local result = ::w.claim();

    ::runningTotal += ::expected[::index];
    ::index++;

    //setup() ran once, and every run since has added to the same table.
    _test.assertEqual(result.runs, ::index);
    _test.assertEqual(result.total, ::runningTotal);
    _test.assertEqual(result.history.len(), ::index);

    if(::index == 1){
        //Hold on to the first claim and mutate it. The worker keeps its own array, so this must
        //not show up in anything claimed later.
        ::firstHistory = result.history;
        ::firstHistory.append(9999);
        _test.assertEqual(::firstHistory.len(), 2);
    }

    if(::index < ::expected.len()){
        _test.assertTrue(::w.dispatch({ amount = ::expected[::index] }));
        return;
    }

    //Three runs in, the worker's own history is untouched by what was done to the first copy.
    _test.assertEqual(result.history.len(), 3);
    for(local i = 0; i < 3; i++){
        _test.assertEqual(result.history[i], ::expected[i]);
    }

    ::w.destroy();
    _test.endTest();
}
