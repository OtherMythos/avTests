//A test which checks vector3 objects.

function start(){

    {
        local vec = Vec3(10, 20, 30);
        _test.assertEqual(vec.x, 10);
        _test.assertEqual(vec.y, 20);
        _test.assertEqual(vec.z, 30);
    }

    { //Assignment
        local vec = Vec3(20, 30, 40);
        local other = null;
        other = vec;
        _test.assertEqual(other.x, 20);
        _test.assertEqual(other.y, 30);
        _test.assertEqual(other.z, 40);
    }

    { //Assignment
        local vec = Vec3(20, 30, 40);
        local other = Vec3(100, 200, 300);
        vec = other
        _test.assertEqual(vec.x, 100);
        _test.assertEqual(vec.y, 200);
        _test.assertEqual(vec.z, 300);
    }

    { //Unary minus.
        local vec = Vec3(10, 20, 30);
        vec = -vec;
        _test.assertEqual(vec.x, -10);
        _test.assertEqual(vec.y, -20);
        _test.assertEqual(vec.z, -30);
    }

    { //Addition single number +=
        local vec = Vec3(10, 20, 30);
        vec += 10;
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 30);
        _test.assertEqual(vec.z, 40);
    }

    { //Addition vector single number +=
        local vec = Vec3(10, 20, 30);
        vec += Vec3(10, 20, 30);
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 40);
        _test.assertEqual(vec.z, 60);
    }

    { //Addition single number
        local vec = Vec3(10, 20, 30);
        vec = vec + 10;
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 30);
        _test.assertEqual(vec.z, 40);

        //Check that the value is not changed without the assignment.
        local secondVec = Vec3(1, 2, 3);
        secondVec + 10;
        _test.assertEqual(secondVec.x, 1);
        _test.assertEqual(secondVec.y, 2);
        _test.assertEqual(secondVec.z, 3);

    }

    { //Addition vector3
        local vec = Vec3(10, 20, 30);
        vec = vec + Vec3(10, 20, 30);
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 40);
        _test.assertEqual(vec.z, 60);

        //Check that the value is not changed without the assignment.
        local secondVec = Vec3(1, 2, 3);
        secondVec + Vec3(1, 2, 3);
        _test.assertEqual(secondVec.x, 1);
        _test.assertEqual(secondVec.y, 2);
        _test.assertEqual(secondVec.z, 3);
    }

    //Minus

    { //Addition single number -=
        local vec = Vec3(20, 30, 40);
        vec -= 10;
        _test.assertEqual(vec.x, 10);
        _test.assertEqual(vec.y, 20);
        _test.assertEqual(vec.z, 30);
    }

    { //Addition vector single number -=
        local vec = Vec3(50, 40, 30);
        vec -= Vec3(10, 20, 30);
        _test.assertEqual(vec.x, 40);
        _test.assertEqual(vec.y, 20);
        _test.assertEqual(vec.z, 0);
    }

    { //Subtraction single number
        local vec = Vec3(20, 30, 40);
        vec = vec - 10;
        _test.assertEqual(vec.x, 10);
        _test.assertEqual(vec.y, 20);
        _test.assertEqual(vec.z, 30);

        //Check that the value is not changed without the assignment.
        local secondVec = Vec3(1, 2, 3);
        secondVec - 1;
        _test.assertEqual(secondVec.x, 1);
        _test.assertEqual(secondVec.y, 2);
        _test.assertEqual(secondVec.z, 3);
    }

    { //Subtraction vector3
        local vec = Vec3(30, 60, 90);
        vec = vec - Vec3(10, 20, 30);
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 40);
        _test.assertEqual(vec.z, 60);

        //Check that the value is not changed without the assignment.
        local secondVec = Vec3(1, 2, 3);
        secondVec - Vec3(1, 2, 3);
        _test.assertEqual(secondVec.x, 1);
        _test.assertEqual(secondVec.y, 2);
        _test.assertEqual(secondVec.z, 3);
    }

    //Multiply

    { //Multiply single number *=
        local vec = Vec3(10, 20, 30);
        vec *= 2;
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 40);
        _test.assertEqual(vec.z, 60);
    }

    { //Multiply vector *=
        local vec = Vec3(10, 20, 30);
        vec *= Vec3(2, 3, 4);
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 60);
        _test.assertEqual(vec.z, 120);
    }

    { //Vector *
        local vec = Vec3(10, 20, 30);
        local newVec = vec * Vec3(2, 3, 4);
        _test.assertEqual(newVec.x, 20);
        _test.assertEqual(newVec.y, 60);
        _test.assertEqual(newVec.z, 120);
    }

    //Divide

    { //Divide single number *=
        local vec = Vec3(10, 20, 30);
        vec /= 2;
        _test.assertEqual(vec.x, 5);
        _test.assertEqual(vec.y, 10);
        _test.assertEqual(vec.z, 15);
    }

    { //Vector /
        local vec = Vec3(10, 20, 40);
        local newVec = vec / Vec3(1, 2, 4);
        _test.assertEqual(newVec.x, 10);
        _test.assertEqual(newVec.y, 10);
        _test.assertEqual(newVec.z, 10);
    }

    { //Empty vector
        local newVec = Vec3();
        _test.assertEqual(newVec.x, 0);
        _test.assertEqual(newVec.y, 0);
        _test.assertEqual(newVec.z, 0);
    }

    {
        local newVec = Vec3(1, 2, 3);
        local vec2 = newVec.xy();
        _test.assertEqual(vec2, Vec2(1, 2));
    }

    _test.endTest();
}
