//A test to check the global registry with the ability to get and set values.

function start(){
    const key = "aKey";
    {
        local target = 10;
        _registry.set(key, target);

        _test.assertEqual(target, _registry.getInt(key));
    }

    {
        local target = 10.0;
        _registry.set(key, target);

        _test.assertEqual(target, _registry.getFloat(key));
    }

    {
        local target = false;
        _registry.set(key, target);

        _test.assertEqual(target, _registry.getBool(key));
    }

    {
        local target = "This is a string";
        _registry.set(key, target);

        _test.assertEqual(target, _registry.getString(key));
    }

    _test.endTest();
}
