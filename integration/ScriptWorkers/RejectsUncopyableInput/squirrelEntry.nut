//Two squirrel vms opened separately do not share a garbage collector or a string table, so only
//values can cross between them. Anything else has to be refused rather than shared, which would
//leave one vm's collector owning memory belonging to the other.

function tryDispatch(input){
    try{
        ::w.dispatch(input);
        return null;
    }catch(e){
        return e.tostring();
    }
}

function start(){
    ::w <- _worker.create("res://worker.nut");

    //A closure, at the top level of the input.
    local error = tryDispatch({ value = 1, callback = function(){} });
    _test.assertNotEqual(error, null);
    //The message has to name the type and where it was, not just say the copy failed.
    _test.assertNotEqual(error.find("closure"), null);
    _test.assertNotEqual(error.find("callback"), null);

    //Rejecting it must leave the worker exactly as it was.
    _test.assertEqual(::w.poll(), _WORKER_IDLE);

    //A closure buried inside a nested container.
    error = tryDispatch({ value = 1, list = [ 1, 2, { deep = function(){} } ] });
    _test.assertNotEqual(error, null);
    _test.assertNotEqual(error.find("closure"), null);
    _test.assertEqual(::w.poll(), _WORKER_IDLE);

    //A class instance.
    class Thing{ constructor(){ mValue = 1; } mValue = 0; }
    error = tryDispatch({ value = 1, instance = Thing() });
    _test.assertNotEqual(error, null);
    _test.assertEqual(::w.poll(), _WORKER_IDLE);

    //Userdata. Vec3 exists in the main vm and deliberately does not in a worker vm.
    error = tryDispatch({ value = 1, position = Vec3(1, 2, 3) });
    _test.assertNotEqual(error, null);
    _test.assertEqual(::w.poll(), _WORKER_IDLE);

    //A table which refers to itself. This must be reported rather than recursed forever.
    local cyclic = { value = 1 };
    cyclic.self <- cyclic;
    error = tryDispatch(cyclic);
    _test.assertNotEqual(error, null);
    _test.assertNotEqual(error.find("cyclic"), null);
    _test.assertEqual(::w.poll(), _WORKER_IDLE);

    //After all of that the worker is still perfectly usable.
    _test.assertTrue(::w.dispatch({ value = 42 }));
    ::finished <- false;
}

function update(){
    if(::finished) return;
    if(::w.poll() != _WORKER_READY) return;

    local result = ::w.claim();
    _test.assertEqual(result.received, 42);
    ::finished = true;

    ::w.destroy();
    _test.endTest();
}
