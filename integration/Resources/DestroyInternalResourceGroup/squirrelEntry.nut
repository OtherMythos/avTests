//Attempt to destroy an internal resource group, check the engine refuses to do that.

function start(){

    local resGroups = _resources.getResourceGroups();
    foreach(i in resGroups){
        print(i);
    }

    {
        local failed = false;
        try{
            _resources.destroyResourceGroup("avInternal/General");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    {
        // local failed = false;
        // try{
            _resources.destroyResourceGroup("Internal");
        // }catch(e){
        //     failed = true;
        // }
        // _test.assertTrue(failed);

        _resources.destroyResourceGroup("General");
        _resources.destroyResourceGroup("Autodetect");
    }

    print("==");

    local resGroups = _resources.getResourceGroups();
    foreach(i in resGroups){
        print(i);
    }

    _test.endTest();
}