//A test to check that components are properly deleted by the system.

function start(){
    _world.createWorld();

    ::en <- _entity.create(SlotPosition());

    //Regular component removal.
    for(local i = 0; i < 5; i++){
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 0);
        _component.user[0].add(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 1);
        _component.user[1].add(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 2);
        _component.user[2].add(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 3);
        _component.user[3].add(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 4);

        _component.user[0].remove(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 3);
        _component.user[1].remove(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 2);
        _component.user[2].remove(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 1);
        _component.user[3].remove(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 0);
    }

    //Destruction by removing the entity.
    for(local i = 0; i < 5; i++){
        en = _entity.create(SlotPosition());

        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 0);
        _component.user[0].add(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 1);
        _component.user[1].add(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 2);
        _component.user[2].add(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 3);
        _component.user[3].add(en);
        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 4);

        _entity.destroy(en);

        _test.assertEqual(_test.userComponents.getNumActiveUserComponents(), 0);
    }

    en = _entity.create(SlotPosition());
    _component.user[0].add(en);
    _component.user[0].remove(en);
    _entity.destroy(en);

    //Check all 16 components can be added properly.
    en = _entity.create(SlotPosition());
    for(local i = 0; i < 16; i++){
        _component.user[i].add(en);
    }
    _entity.destroy(en);

    _test.endTest();
}

function update(){

}
