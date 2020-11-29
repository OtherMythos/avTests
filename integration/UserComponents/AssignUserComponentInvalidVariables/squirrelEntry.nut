//A test to check that invalid and badly formed component definitions can be setup correctly.

function start(){
    _world.createWorld();

    ::en <- _entity.create(SlotPosition());
    local numComponents = _test.userComponents.getNumUserComponents();
    _test.assertEqual(numComponents, 4);

    local list = _test.userComponents.getUserComponentNames();
    _test.assertEqual(list.len(), numComponents);
    local expectedVals = ["1", "2", "4", "5"];

    //Check the expected values
    foreach(i in list){
        local found = false;
        for(local y = 0; y < expectedVals.len(); y++){
            if(expectedVals[y] == i) found = true;
        }
        _test.assertTrue(found);
    }

    _test.endTest();
}

function update(){

}
