//Two things at once, because both need a run which is slow enough to catch in the act:
//  - the main thread really does keep running frames while the worker works, and can read the
//    progress the worker publishes
//  - destroying a worker mid run is safe. Its vm cannot be closed while a pool thread is inside
//    it, so the handle goes stale immediately and the vm is closed once the run stops.

function start(){
    ::w <- _worker.create("res://worker.nut");
    _test.assertTrue(::w.dispatch({ steps = 40 }));

    ::frames <- 0;
    ::sawRunning <- false;
    ::maxProgress <- 0.0;
    ::destroyed <- false;
    ::framesAfterDestroy <- 0;
}

function update(){
    ::frames++;

    if(!::destroyed){
        local state = ::w.poll();
        if(state == _WORKER_RUNNING) ::sawRunning = true;

        local p = ::w.progress();
        if(p > ::maxProgress) ::maxProgress = p;

        //Wait until the run is properly under way, then pull the worker out from under it.
        if(::sawRunning && ::maxProgress > 0.0){
            ::w.destroy();
            ::destroyed = true;

            //Stale straight away, whether or not the vm could be closed yet.
            _test.assertEqual(::w.poll(), _WORKER_DESTROYED);
            //A stale handle reports rather than throws, so a polling loop needs no try block.
            _test.assertEqual(::w.progress(), 0.0);
            _test.assertEqual(::w.error(), null);
        }

        //The run is far slower than a frame, so this should never be reached.
        if(::frames > 2000){
            _test.assertTrue(false);
            _test.endTest(false);
        }
        return;
    }

    //Keep running frames afterwards. The manager reaps the worker in one of these, and nothing
    //here may crash or stall while a cancelled run is still winding down.
    ::framesAfterDestroy++;
    if(::framesAfterDestroy < 60) return;

    _test.assertTrue(::sawRunning);
    _test.assertTrue(::maxProgress > 0.0);
    _test.assertTrue(::maxProgress <= 1.0);
    _test.assertEqual(::w.poll(), _WORKER_DESTROYED);

    _test.endTest();
}
