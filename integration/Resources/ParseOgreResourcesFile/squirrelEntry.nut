//A test to check scripts can request an OgreResources file to be parsed, and that these resource locations are added correctly.

function start(){

    //Start with no resource locations specified.

    //Should fail to parse as the resources are not available.
    local failed = false;
    try{
        local texture = MovableTexture("cat2.jpg");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    _resources.parseOgreResourcesFile("res://OgreResources.cfg");
    _resources.initialiseAllResourceGroups();

    //Should be able to load it now
    local texture = MovableTexture("cat1.jpg");

    _test.endTest();
}