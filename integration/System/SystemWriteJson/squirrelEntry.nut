//A test which tries to write json files, reading them back in at a later date.

function start(){

    local data = {
        "first": false,
        "second": 10,
        "third": "some text",
        "arrayVal": [10, false, "hello"],
        "fourth":{
            "firstTable": "something",
            "secondTable": true,
            "thirdTable": null,
            "fourthTable": 10,
            "fifthTable": 10.123,
            "inner":{ "thing": false },
            "arrayInner": [[10, 20], [30, 40]]
        }
    };
    _system.writeJsonAsFile("/tmp/writtenThing.json", data);


    //Read the values back to check.
    local value = _system.readJSONAsTable("/tmp/writtenThing.json");
    _test.assertEqual(typeof(value), "table");

    _test.assertEqual(value["first"], false);
    _test.assertEqual(value["second"], 10);
    _test.assertEqual(value["third"], "some text");

    _test.assertEqual(typeof(value["arrayVal"]), "array");
    _test.assertEqual(value["arrayVal"][0], 10);
    _test.assertEqual(value["arrayVal"][1], false);
    _test.assertEqual(value["arrayVal"][2], "hello");

    _test.assertEqual(value["fourth"]["firstTable"], "something");
    _test.assertEqual(value["fourth"]["secondTable"], true);
    _test.assertEqual(value["fourth"]["thirdTable"], null);
    _test.assertEqual(value["fourth"]["fourthTable"], 10);
    _test.assertEqual(value["fourth"]["fifthTable"], 10.123);

    _test.assertEqual(value["fourth"]["inner"]["thing"], false);

    _test.assertEqual(value["fourth"]["arrayInner"][0][0], 10);
    _test.assertEqual(value["fourth"]["arrayInner"][0][1], 20);
    _test.assertEqual(value["fourth"]["arrayInner"][1][0], 30);
    _test.assertEqual(value["fourth"]["arrayInner"][1][1], 40);

    //Try and write an invalid file.
    local failed = false;
    try{
        _system.writeJsonAsFile("", data);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    _test.endTest();
}