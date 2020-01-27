//A test to check that the registry get function returns the correct type.

function start(){
    const key = "aKey";

    //While the get function is able to return variables of any type, generally you should use the getType (i.e getString) functions, as they can do validity checks as well.
    _registry.set(key, false);
    _test.assertEqual(_registry.get(key), false);

    _registry.set(key, 10);
    _test.assertEqual(_registry.get(key), 10);

    _registry.set(key, 20.1234);
    _test.assertEqual(_registry.get(key), 20.1234);

    _registry.set(key, "someText");
    _test.assertEqual(_registry.get(key), "someText");

    _test.assertEqual(_registry.get("keyThatDoesntExist"), null);

    _test.endTest();
}
