//A test which tries to write json files, reading them back in at a later date.

function checkWrittenJSON(){
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
}

function getNumLinesInFile(path){
    local text = File();
    text.open(path);
    local total = 0;

    while(!text.eof()){
        local line = text.getLine();
        total++;
    }
    return total;
}

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

    checkWrittenJSON();
    local num = getNumLinesInFile("/tmp/writtenThing.json");
    _test.assertTrue(num > 1);

    //Try and write an invalid file.
    local failed = false;
    try{
        _system.writeJsonAsFile("", data);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);


    //Write without pretty print.
    _system.writeJsonAsFile("/tmp/writtenThing.json", data, false);
    checkWrittenJSON();

    //Check the file is one line.
    local num = getNumLinesInFile("/tmp/writtenThing.json");
    _test.assertEqual(num, 1);

    //Check I can have more than one end value without crashes.
    _system.writeJsonAsFile("/tmp/writtenThing.json", data, false, true, 10, 20);
    checkWrittenJSON();
    local num = getNumLinesInFile("/tmp/writtenThing.json");
    print(num);
    _test.assertTrue(num > 1);

    _test.endTest();
}