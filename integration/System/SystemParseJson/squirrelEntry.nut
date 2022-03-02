//A test which checks system json files can ge parsed correctly.

function start(){

    {
        local failed = false;
        try{
            local value = _system.readJSONAsTable("res://res/brokenJSON.json");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }
    //Check it fails for an invalid file.
    {
        local failed = false;
        try{
            local value = _system.readJSONAsTable("res://res/doesntExist.json");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    local value = _system.readJSONAsTable("res://res/fullJSON.json");
    _test.assertEqual(typeof(value), "table");
    _test.assertEqual(value.len(), 7);

    _test.assertFalse(value.boolVal);
    _test.assertTrue(value.boolTrueVal);
    _test.assertEqual(value.stringVal, "something");
    _test.assertEqual(value.floatVal, 10.12);
    _test.assertEqual(value.intVal, 10);

    _test.assertEqual(typeof(value.arrayVal), "array");
    _test.assertEqual(value.arrayVal[0], 20);
    _test.assertEqual(value.arrayVal[1], 30);

    _test.assertEqual(value.objectVal.first, 10);
    _test.assertEqual(value.objectVal.second, 20.10);
    _test.assertEqual(value.objectVal.third, false);
    _test.assertEqual(value.objectVal.fourth, null);

    _test.assertEqual(value.objectVal.fifth.other, "value");
    _test.assertEqual(value.objectVal.fifth.second[0], "hello");
    _test.assertEqual(value.objectVal.fifth.second[1], "again");

    _test.endTest();
}