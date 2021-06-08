//A test to check that I can assign render queues to objects.

function start(){

    //Check all render queues are registered as Ogre::FAST.
    //This is abstracted from the user, but if they weren't ogre would have asserted by this point.
    for(local i = 0; i < 100; i++){
        local item = _scene.createItem("cube");
        item.setRenderQueueGroup(i);
        local node = _scene.getRootSceneNode().createChildSceneNode();
        node.attachObject(item);
    }

    local testItem = _scene.createItem("cube");

    local failed = false;
    try{
        testItem.setRenderQueueGroup(200);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    failed = false;
    try{
        testItem.setRenderQueueGroup(-10);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);
}

function update(){
}
