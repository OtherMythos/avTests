//Check user components can fail in the expected way

enum Components{
    HEALTH,
    BUFFS,
    SHORT
};
enum HealthVariables{
    FIRST,
    SECOND,
    THIRD,
    FOURTH
};
enum BuffVariables{
    FIRST,
    SECOND,
    THIRD,
    FOURTH
};
enum ShortVariables{
    FIRST,
    NOT_POPULATED
};

function start(){
    _world.createWorld();

    {
        local en = _entity.create(SlotPosition());

        //Check values can't be set if that entity doesn't have that component.
        local failed = false;
        try{
            _component.user[Components.HEALTH].set(en, HealthVariables.FIRST, 20.123);
            _component.user[Components.HEALTH].get(en, HealthVariables.FIRST);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    {
        local en = _entity.create(SlotPosition());

        //Check values can't be set if that entity doesn't have that component.
        local failed = false;
        try{
            _component.user[Components.SHORT].set(en, ShortVariables.NOT_POPULATED, 23);
            _component.user[Components.SHORT].get(en, ShortVariables.NOT_POPULATED);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    _test.endTest();
}

function update(){

}
