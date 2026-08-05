//A test to check the plane data type.

function start(){

    { //Default constructor.
        local plane = Plane();
        _test.assertEqual(plane.tostring(), "Plane(normal=Vector3(0, 0, 0), d=0)");
        _test.assertEqual(plane, Plane());
    }

    { //Normal and a point which lies on the plane. d becomes -normal.dot(point).
        local plane = Plane(Vec3(1, 2, 3), Vec3(1, 0, -1));
        _test.assertEqual(plane.tostring(), "Plane(normal=Vector3(1, 2, 3), d=2)");

        //The normal/constant constructor negates the constant, so this describes the same plane.
        _test.assertEqual(plane, Plane(Vec3(1, 2, 3), -2));
        //Neither of these constructors normalise the normal.
        _test.assertNotEqual(plane, Plane(Vec3(1, 2, 3).normalisedCopy(), -2));
    }

    { //Normal and a constant.
        local plane = Plane(Vec3(1, 2, 3), 3);
        _test.assertEqual(plane.tostring(), "Plane(normal=Vector3(1, 2, 3), d=-3)");

        //An integer and a float constant should be treated the same.
        _test.assertEqual(plane, Plane(Vec3(1, 2, 3), 3.0));

        _test.assertNotEqual(plane, Plane(Vec3(1, 2, 3), 4));
        _test.assertNotEqual(plane, Plane(Vec3(3, 2, 1), 3));
        //Check the two argument constructor really does dispatch on the second type.
        _test.assertNotEqual(plane, Plane(Vec3(1, 2, 3), Vec3(1, 0, -1)));
    }

    { //Three points. Values are chosen so that no rounding occurs.
        //The normal is (p1 - p0) x (p2 - p0), so the winding order decides which way it faces.
        local plane = Plane(Vec3(0, 0, 0), Vec3(1, 0, 0), Vec3(0, 0, 1));
        _test.assertEqual(plane, Plane(Vec3(0, -1, 0), 0));

        //Unlike the other constructors this one normalises, so a longer cross product
        //taken from the same plane produces the same result.
        local scaled = Plane(Vec3(0, 0, 0), Vec3(2, 0, 0), Vec3(0, 0, 2));
        _test.assertEqual(scaled, plane);
        _test.assertNotEqual(scaled, Plane(Vec3(0, -4, 0), 0));

        //Reversing the winding flips the normal.
        _test.assertNotEqual(plane, Plane(Vec3(0, 0, 0), Vec3(0, 0, 1), Vec3(1, 0, 0)));

        //A plane which doesn't pass through the origin.
        local offset = Plane(Vec3(0, 5, 0), Vec3(1, 5, 0), Vec3(0, 5, 1));
        _test.assertEqual(offset, Plane(Vec3(0, -1, 0), -5));
    }

    { //Copy.
        local plane = Plane(Vec3(1, 2, 3), 3);
        local copied = plane.copy();
        _test.assertEqual(copied, plane);

        //The copy is independent of the original.
        plane = Plane();
        _test.assertEqual(copied, Plane(Vec3(1, 2, 3), 3));
        _test.assertNotEqual(copied, plane);
    }

    { //Invalid number of parameters.
        local failed = false;
        try{
            Plane(Vec3(1, 2, 3));
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    { //Invalid parameter types.
        local failed = false;
        try{
            Plane(1, 2);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    { //Comparison against something which isn't a plane.
        //Note this has to be a relational operator. == against userdata doesn't reach _cmp.
        local failed = false;
        try{
            local equal = Plane() > Vec3(0);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    _test.endTest();
}
