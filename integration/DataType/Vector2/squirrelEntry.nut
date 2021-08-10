//A test which checks custom user settings appear in the setup file.

function start(){

    {
        local vec = Vec2(10, 20);
        _test.assertEqual(vec.x, 10);
        _test.assertEqual(vec.y, 20);
    }

    { //Assignment
        local vec = Vec2(20, 30);
        local other = null;
        other = vec;
        _test.assertEqual(other.x, 20);
        _test.assertEqual(other.y, 30);
    }

    { //Assignment
        local vec = Vec2(20, 30);
        local other = Vec2(100, 200);
        vec = other
        _test.assertEqual(vec.x, 100);
        _test.assertEqual(vec.y, 200);
    }

    { //Unary minus.
        local vec = Vec2(10, 20);
        vec = -vec;
        _test.assertEqual(vec.x, -10);
        _test.assertEqual(vec.y, -20);
    }

    { //Addition single number +=
        local vec = Vec2(10, 20);
        vec += 10;
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 30);
    }

    { //Addition vector single number +=
        local vec = Vec2(10, 20);
        vec += Vec2(10, 20);
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 40);
    }

    { //Addition single number
        local vec = Vec2(10, 20);
        vec = vec + 10;
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 30);

        //Check that the value is not changed without the assignment.
        local secondVec = Vec2(1, 2);
        secondVec + 10;
        _test.assertEqual(secondVec.x, 1);
        _test.assertEqual(secondVec.y, 2);

    }

    { //Addition vector3
        local vec = Vec2(10, 20);
        vec = vec + Vec2(10, 20);
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 40);

        //Check that the value is not changed without the assignment.
        local secondVec = Vec2(1, 2);
        secondVec + Vec2(1, 2);
        _test.assertEqual(secondVec.x, 1);
        _test.assertEqual(secondVec.y, 2);
    }

    //Minus

    { //Addition single number -=
        local vec = Vec2(20, 30);
        vec -= 10;
        _test.assertEqual(vec.x, 10);
        _test.assertEqual(vec.y, 20);
    }

    { //Addition vector single number -=
        local vec = Vec2(50, 40);
        vec -= Vec2(10, 20);
        _test.assertEqual(vec.x, 40);
        _test.assertEqual(vec.y, 20);
    }

    { //Subtraction single number
        local vec = Vec2(20, 30);
        vec = vec - 10;
        _test.assertEqual(vec.x, 10);
        _test.assertEqual(vec.y, 20);

        //Check that the value is not changed without the assignment.
        local secondVec = Vec2(1, 2);
        secondVec - 1;
        _test.assertEqual(secondVec.x, 1);
        _test.assertEqual(secondVec.y, 2);
    }

    { //Subtraction vector3
        local vec = Vec2(30, 60);
        vec = vec - Vec2(10, 20);
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 40);

        //Check that the value is not changed without the assignment.
        local secondVec = Vec2(1, 2);
        secondVec - Vec2(1, 2);
        _test.assertEqual(secondVec.x, 1);
        _test.assertEqual(secondVec.y, 2);
    }

    //Multiply

    { //Multiply single number *=
        local vec = Vec2(10, 20);
        vec *= 2;
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 40);
    }

    { //Multiply vector *=
        local vec = Vec2(10, 20);
        vec *= Vec2(2, 3);
        _test.assertEqual(vec.x, 20);
        _test.assertEqual(vec.y, 60);
    }

    { //Vector *
        local vec = Vec2(10, 20);
        local newVec = vec * Vec2(2, 3);
        _test.assertEqual(newVec.x, 20);
        _test.assertEqual(newVec.y, 60);
    }

    //Divide

    { //Divide single number *=
        local vec = Vec2(10, 20);
        vec /= 2;
        _test.assertEqual(vec.x, 5);
        _test.assertEqual(vec.y, 10);
    }

    { //Vector /
        local vec = Vec2(10, 20);
        local newVec = vec / Vec2(1, 2);
        _test.assertEqual(newVec.x, 10);
        _test.assertEqual(newVec.y, 10);
    }

    { //Empty vector
        local newVec = Vec2();
        _test.assertEqual(newVec.x, 0);
        _test.assertEqual(newVec.y, 0);
    }

    _test.endTest();
}
