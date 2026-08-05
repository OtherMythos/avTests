//Checks the core loop of the script worker system: a script file is handed to a worker thread,
//run there with an input table, and its return value is copied back into the main vm to be claimed.

function start(){
    //The namespace only exists when ScriptWorkers is enabled in the setup file, which is how a
    //project checks for the feature.
    _test.assertTrue("_worker" in getroottable());

    ::w <- _worker.create("res://worker.nut");
    _test.assertEqual(::w.poll(), _WORKER_IDLE);
    _test.assertEqual(::w.error(), null);

    _test.assertTrue(::w.dispatch({ count = 5, multiplier = 3 }));
    //Dispatching again while busy reports false rather than throwing or queueing a second run.
    _test.assertFalse(::w.dispatch({ count = 1, multiplier = 1 }));

    ::claimed <- false;
}

function update(){
    if(::claimed) return;

    local state = ::w.poll();
    if(state != _WORKER_READY) return;

    local result = ::w.claim();
    ::claimed = true;

    //Every kind of value the copier is meant to support has to survive the trip back.
    _test.assertEqual(typeof result, "table");
    _test.assertEqual(result.label, "from the worker");
    _test.assertEqual(result.executionFlag, 1);
    _test.assertEqual(result.nested.depth.value, 5);

    _test.assertEqual(result.values.len(), 5);
    for(local i = 0; i < 5; i++){
        _test.assertEqual(result.values[i], i * 3);
    }

    //Claiming returns the worker to idle so it can be used again.
    _test.assertEqual(::w.poll(), _WORKER_IDLE);
    _test.assertEqual(::w.error(), null);

    ::w.destroy();
    _test.assertEqual(::w.poll(), _WORKER_DESTROYED);

    _test.endTest();
}
