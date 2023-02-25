//A test which checks the functionality of the quaternion user data.

function start(){

    {
        local quat = Quat(10, 20, 30, 40);
        _test.assertEqual(quat.x, 10);
        _test.assertEqual(quat.y, 20);
        _test.assertEqual(quat.z, 30);
        _test.assertEqual(quat.w, 40);
    }


    { //Assignment
        local quat = Quat(10, 20, 30, 40);
        local other = null;
        other = quat;
        _test.assertEqual(quat.x, 10);
        _test.assertEqual(quat.y, 20);
        _test.assertEqual(quat.z, 30);
        _test.assertEqual(quat.w, 40);
    }


    { //Assignment
        local quat = Quat(10, 20, 30, 40);
        local other = Quat(100, 200, 300, 400);
        quat = other
        _test.assertEqual(quat.x, 100);
        _test.assertEqual(quat.y, 200);
        _test.assertEqual(quat.z, 300);
        _test.assertEqual(quat.w, 400);
    }

    { //Unary minus.
        local quat = Quat(10, 20, 30, 40);
        quat = -quat;
        _test.assertEqual(quat.x, -10);
        _test.assertEqual(quat.y, -20);
        _test.assertEqual(quat.z, -30);
        _test.assertEqual(quat.w, -40);
    }

    { //Empty constructor
        local quat = Quat();
        _test.assertEqual(quat.x, 0);
        _test.assertEqual(quat.y, 0);
        _test.assertEqual(quat.z, 0);
        _test.assertEqual(quat.w, 1);
    }

    //Invalid parameters
    {
        local things = [
            function() { Quat("hello") },
            function() { Quat(10, "hello") },
            function() { Quat(10, 10, 10, 10, "text") },
            function() { Quat(false, 10, 10, 10, 10) },
            function() { Quat(10) },
        ]

        foreach(c,i in things){
            local failed = false;
            try{
                i();
            }catch(e){
                failed = true;
            }
            _test.assertTrue(failed);
            print("Success " + c);
        }
    }

    //copy
    {
        local first = Quat(10, 20, 30, 40);
        local second = first.copy();
        first.x = 1;

        _test.assertFalse(first == second);
        _test.assertEqual(first.x, 1);
        _test.assertEqual(second.x, 10);
    }

    _test.endTest();
}
