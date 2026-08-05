//The setup file for this test deliberately has no ScriptWorkers entry.
//
//Most projects will never want a worker thread, so the feature costs them nothing at all - the
//namespace, its constants and the handle delegate table are simply never registered, and no
//manager is constructed. That absence is also how a script checks whether the feature is
//available, which is why there is no _worker.enabled().

function start(){
    _test.assertFalse("_worker" in getroottable());

    //The state constants come with the namespace, so they are absent too.
    _test.assertFalse("_WORKER_IDLE" in getconsttable());
    _test.assertFalse("_WORKER_READY" in getconsttable());
    _test.assertFalse("_WORKER_DESTROYED" in getconsttable());

    //Reaching for it anyway is an ordinary missing index error, the same as any other namespace
    //which was not compiled in.
    local threw = false;
    try{
        _worker.create("res://nothing.nut");
    }catch(e){
        threw = true;
    }
    _test.assertTrue(threw);

    //EXECUTION_WORKER_VM is declared unconditionally, so a file shared with a worker can branch
    //on it whether or not the feature is on.
    _test.assertEqual(EXECUTION_WORKER_VM, 0);

    _test.endTest();
}
