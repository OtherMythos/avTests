//A test which checks deleting values within the registry works.

function start(){
    const key = "aKey";

    _registry.set("something", 10);
    _test.assertEqual(10, _registry.getInt("something"));

    _registry.set("something", null);
    _test.assertEqual(null, _registry.getInt("something"));

    _test.endTest();
}
