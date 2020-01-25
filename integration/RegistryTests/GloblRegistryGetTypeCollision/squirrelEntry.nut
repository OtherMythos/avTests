//A test to check that the registry get functions return the expected result after a type collision.

function start(){
    const key = "aKey";

    _registry.set(key, false);

    _test.assertEqual(null, _registry.getInt(key));
    _test.assertEqual(null, _registry.getFloat(key));
    _test.assertEqual(null, _registry.getString(key));

    _test.assertEqual(false, _registry.getBool(key)); //Should be able to return the boolean fine.
    _registry.set(key, 10); //Make it an int now
    _test.assertEqual(null, _registry.getBool(key));

    _test.endTest();
}
