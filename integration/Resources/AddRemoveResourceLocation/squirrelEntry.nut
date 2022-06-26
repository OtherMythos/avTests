//A test to check resource locations can be added dynamically.

function start(){

    _resources.addResourceLocation("res://loc/first", "FileSystem", "General");
    //Trigger an update in the resource group so it sees the new location.
    //_resources.initialiseResourceGroup("createdGroup");
    _resources.prepareResourceGroup("General");

    {
        //Cat1 should be available.
        local texture = MovableTexture("cat1.jpg");

        //Cat2 should not be available as the location does not exist.
        local failed = false;
        try{
            local texture = MovableTexture("cat2.jpg");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    {
        _resources.addResourceLocation("res://loc/other", "FileSystem", "createdGroup");
        _resources.initialiseResourceGroup("createdGroup");

        //Cat2 should now be available in group 'createdGroup'.
        local failed = false;
        try{
            local texture = MovableTexture("cat2.jpg");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);

        local texture = MovableTexture("cat2.jpg", "createdGroup");
    }

    {
        //Remove the created group and check that loading no longer happens.
        _resources.destroyResourceGroup("createdGroup");

        local failed = false;
        try{
            local texture = MovableTexture("cat2.jpg", "createdGroup");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    {
        //Try removing it again and it should throw an error.
        local failed = false;
        try{
            _resources.destroyResourceGroup("createdGroup");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    _test.endTest();
}