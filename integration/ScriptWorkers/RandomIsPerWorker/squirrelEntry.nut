//Two workers seeded identically must produce identical sequences, and seeding one must not
//disturb the other. That only holds if each worker owns its generator - the main vm's _random is
//rand()/srand(), which is process wide and would have two worker threads interleaving.

function start(){
    ::a <- _worker.create("res://worker.nut");
    ::b <- _worker.create("res://worker.nut");
    ::c <- _worker.create("res://worker.nut");

    //a and b share a seed. c is seeded differently.
    _test.assertTrue(::a.dispatch({ seed = 4242 }));
    _test.assertTrue(::b.dispatch({ seed = 4242 }));
    _test.assertTrue(::c.dispatch({ seed = 99 }));

    ::resultA <- null;
    ::resultB <- null;
    ::resultC <- null;
    ::finished <- false;
}

function collect(worker, current){
    if(current != null) return current;
    if(worker.poll() != _WORKER_READY) return null;
    return worker.claim();
}

function update(){
    if(::finished) return;

    ::resultA = collect(::a, ::resultA);
    ::resultB = collect(::b, ::resultB);
    ::resultC = collect(::c, ::resultC);

    if(::resultA == null || ::resultB == null || ::resultC == null) return;
    ::finished = true;

    //Same seed, same sequence, whichever pool thread each happened to run on.
    for(local i = 0; i < ::resultA.ints.len(); i++){
        _test.assertEqual(::resultA.ints[i], ::resultB.ints[i]);
    }
    for(local i = 0; i < ::resultA.floats.len(); i++){
        _test.assertEqual(::resultA.floats[i], ::resultB.floats[i]);
    }
    _test.assertEqual(::resultA.index, ::resultB.index);

    //A different seed has to give a different sequence, otherwise the seed is being ignored.
    local differs = false;
    for(local i = 0; i < ::resultA.ints.len(); i++){
        if(::resultA.ints[i] != ::resultC.ints[i]) differs = true;
    }
    _test.assertTrue(differs);

    //randInt respects its bounds and randIndex stays inside the array.
    foreach(v in ::resultA.ints){
        _test.assertTrue(v >= 0 && v <= 1000000);
    }
    foreach(v in ::resultA.floats){
        _test.assertTrue(v >= 0.0 && v <= 1.0);
    }
    _test.assertTrue(::resultA.index >= 0 && ::resultA.index < 5);

    ::a.destroy();
    ::b.destroy();
    ::c.destroy();

    _test.endTest();
}
