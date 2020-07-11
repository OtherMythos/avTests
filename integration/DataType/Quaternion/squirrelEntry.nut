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

    _test.endTest();
}
