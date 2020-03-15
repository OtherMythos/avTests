function first(a){
    _test.assertEqual(a, 10);
}

function second(a, b, c, d){
    _test.assertEqual(a, 10);
    _test.assertEqual(b, 20);
    _test.assertEqual(c, 30);
    _test.assertEqual(d, 40);
}

function third(a, b, c, d){
    _test.assertEqual(typeof a, "float");
    _test.assertEqual(typeof b, "integer");
    _test.assertEqual(typeof c, "string");
    _test.assertEqual(typeof d, "bool");

    _test.assertEqual(a, 10.12);
    _test.assertEqual(b, 20);
    _test.assertEqual(c, "someValue");
    _test.assertEqual(d, false);
}

function vFirst(a, b, c, d){
    _test.assertEqual(typeof a, "integer");
    _test.assertEqual(typeof b, "float");
    _test.assertEqual(typeof c, "bool");
    _test.assertEqual(typeof d, "string");

    _test.assertEqual(a, 10);
    _test.assertEqual(b, 12.45);
    _test.assertEqual(c, false);
    _test.assertEqual(d, "a string");
}

function vSecond(a, b, c, d){
    _test.assertEqual(typeof a, "integer");
    _test.assertEqual(typeof b, "float");
    _test.assertEqual(typeof c, "bool");
    _test.assertEqual(typeof d, "string");

    _test.assertEqual(a, 20);
    _test.assertEqual(b, 45.12);
    _test.assertEqual(c, true);
    _test.assertEqual(d, "local string");
}

function vThird(a, b, c, d){
    //A mix of both constants and variables.

    _test.assertEqual(a, 10); //global variable
    _test.assertEqual(b, 20); //constant
    _test.assertEqual(c, true); //local variable
    _test.assertEqual(d, 35.2); //constant
}
