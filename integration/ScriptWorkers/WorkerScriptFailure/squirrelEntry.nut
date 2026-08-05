//A worker script throwing must be reported to the main thread through the handle, and must not
//take the engine down the way a main vm script failure does.

function start(){
    ::w <- _worker.create("res://worker.nut");
    _test.assertTrue(::w.dispatch({}));

    ::stage <- 0;
}

function update(){
    if(::stage == 0){
        if(::w.poll() != _WORKER_FAILED) return;

        //The reason the run failed is readable before it is claimed.
        local error = ::w.error();
        _test.assertNotEqual(error, null);
        _test.assertNotEqual(error.find("deliberate failure inside the worker"), null);

        //Claiming a failed run yields null and clears the error.
        local result = ::w.claim();
        _test.assertEqual(result, null);
        _test.assertEqual(::w.error(), null);
        _test.assertEqual(::w.poll(), _WORKER_IDLE);

        //The vm is still intact, so the worker can be used again.
        _test.assertTrue(::w.dispatch({}));
        ::stage = 1;
        return;
    }

    if(::stage == 1){
        if(::w.poll() != _WORKER_READY) return;

        local result = ::w.claim();
        //setup() ran once and the failed run still incremented the counter, so this is the second.
        _test.assertEqual(result.calls, 2);
        ::stage = 2;

        ::w.destroy();
        _test.endTest();
    }
}
