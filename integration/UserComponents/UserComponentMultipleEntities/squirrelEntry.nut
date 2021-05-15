//Check that if multiple entities exist their user components don't conflict.

enum Components{
    HEALTH,
    BUFFS
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

function start(){
    _world.createWorld();

    ::en <- _entity.create(SlotPosition());
    ::en2 <- _entity.create(SlotPosition());

    _component.user[Components.HEALTH].add(en);
    _component.user[Components.HEALTH].add(en2);

    local entities = [en, en2];
    foreach(c,e in entities){
        local val = c + 1;
        _component.user[Components.HEALTH].set(e, HealthVariables.FIRST, 20.123*val);
        _component.user[Components.HEALTH].set(e, HealthVariables.SECOND, 34*val);
        _component.user[Components.HEALTH].set(e, HealthVariables.THIRD, false);
        _component.user[Components.HEALTH].set(e, HealthVariables.FOURTH, 12.345*val);

        _test.assertEqual(_component.user[Components.HEALTH].get(e, HealthVariables.FIRST), 20.123*val);
        _test.assertEqual(_component.user[Components.HEALTH].get(e, HealthVariables.SECOND), 34*val);
        _test.assertEqual(_component.user[Components.HEALTH].get(e, HealthVariables.THIRD), false);
        _test.assertEqual(_component.user[Components.HEALTH].get(e, HealthVariables.FOURTH), 12.345*val);
    }

    _test.endTest();
}

function update(){

}
