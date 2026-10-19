//A tag names exactly one node, so a scene file claiming one twice must not parse.

function start(){

    local failed = false;
    try{
        _scene.parseSceneFile("res://res/sceneDuplicateTags.avscene");
    }catch(e){
        print(e);
        failed = true;
    }
    _test.assertTrue(failed);

    _test.endTest();
}
