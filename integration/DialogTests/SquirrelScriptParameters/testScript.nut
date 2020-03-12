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
