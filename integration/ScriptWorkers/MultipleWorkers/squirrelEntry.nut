//More workers than the job pool has threads, all dispatched in one burst.
//
//The pool defaults to two threads, so some of these runs must sit queued until a thread frees up.
//Nothing may deadlock and every run has to land. This is the shape which caught a lock ordering
//bug in JobDispatcher, where a worker could park itself as idle in the gap while a dispatch had
//already decided there was none - leaving a job queued with nothing coming back for it.

::WORKER_COUNT <- 4;

function start(){
    ::workers <- [];
    ::claimed <- [];

    for(local i = 0; i < ::WORKER_COUNT; i++){
        local w = _worker.create("res://worker.nut");
        ::workers.append(w);
        ::claimed.append(null);
    }

    //Every worker is its own vm, so all four dispatch straight away regardless of pool size.
    for(local i = 0; i < ::WORKER_COUNT; i++){
        _test.assertTrue(::workers[i].dispatch({ id = i }));
        _test.assertNotEqual(::workers[i].poll(), _WORKER_IDLE);
    }

    ::remaining <- ::WORKER_COUNT;
}

function update(){
    if(::remaining <= 0) return;

    for(local i = 0; i < ::WORKER_COUNT; i++){
        if(::claimed[i] != null) continue;

        local state = ::workers[i].poll();
        if(state == _WORKER_FAILED){
            print("worker " + i + " failed: " + ::workers[i].error());
            _test.endTest(false);
            return;
        }
        if(state != _WORKER_READY) continue;

        local result = ::workers[i].claim();
        ::claimed[i] = result;
        ::remaining--;

        //Each worker kept its own identity, so no two shared a vm or a result.
        _test.assertEqual(result.id, i);
        _test.assertEqual(result.echoed, i);
    }

    if(::remaining > 0) return;

    //All four ran the same loop, so every checksum has to agree.
    local first = ::claimed[0].checksum;
    for(local i = 1; i < ::WORKER_COUNT; i++){
        _test.assertEqual(::claimed[i].checksum, first);
    }

    for(local i = 0; i < ::WORKER_COUNT; i++){
        ::workers[i].destroy();
        _test.assertEqual(::workers[i].poll(), _WORKER_DESTROYED);
    }

    _test.endTest();
}
