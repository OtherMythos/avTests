//A test to check that user components can be added and removed from an entity.

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

    _component.user[Components.HEALTH].add(en);
    _component.user[Components.BUFFS].add(en);

    _component.user[Components.HEALTH].set(en, HealthVariables.FIRST, 20.123);
    _component.user[Components.HEALTH].set(en, HealthVariables.SECOND, 34);
    _component.user[Components.HEALTH].set(en, HealthVariables.THIRD, false);
    _component.user[Components.HEALTH].set(en, HealthVariables.FOURTH, 12.345);

    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.FIRST), 20.123);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.SECOND), 34);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.THIRD), false);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.FOURTH), 12.345);

    //Check buffs
    _component.user[Components.BUFFS].set(en, BuffVariables.FIRST, 1);
    _component.user[Components.BUFFS].set(en, BuffVariables.SECOND, 2);
    _component.user[Components.BUFFS].set(en, BuffVariables.THIRD, 3);
    _component.user[Components.BUFFS].set(en, BuffVariables.FOURTH, 4);

    _test.assertEqual(_component.user[Components.BUFFS].get(en, BuffVariables.FIRST), 1);
    _test.assertEqual(_component.user[Components.BUFFS].get(en, BuffVariables.SECOND), 2);
    _test.assertEqual(_component.user[Components.BUFFS].get(en, BuffVariables.THIRD), 3);
    _test.assertEqual(_component.user[Components.BUFFS].get(en, BuffVariables.FOURTH), 4);

    _component.user[Components.HEALTH].set(en, HealthVariables.FIRST, 20.123);
    _component.user[Components.HEALTH].set(en, HealthVariables.SECOND, 34);
    _component.user[Components.HEALTH].set(en, HealthVariables.THIRD, false);
    _component.user[Components.HEALTH].set(en, HealthVariables.FOURTH, 12.345);

    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.FIRST), 20.123);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.SECOND), 34);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.THIRD), false);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.FOURTH), 12.345);

    //Remove the component from the entity.
    _component.user[Components.BUFFS].remove(en);
    _component.user[Components.HEALTH].remove(en);

    _component.user[Components.HEALTH].add(en);
    _component.user[Components.BUFFS].add(en);

    _component.user[Components.HEALTH].set(en, HealthVariables.FIRST, 40.456);
    _component.user[Components.HEALTH].set(en, HealthVariables.SECOND, 65);
    _component.user[Components.HEALTH].set(en, HealthVariables.THIRD, true);
    _component.user[Components.HEALTH].set(en, HealthVariables.FOURTH, 24.456);

    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.FIRST), 40.456);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.SECOND), 65);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.THIRD), true);
    _test.assertEqual(_component.user[Components.HEALTH].get(en, HealthVariables.FOURTH), 24.456);

    _test.endTest();
}

function update(){

}
