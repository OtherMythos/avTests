//A test which checks custom user settings appear in the setup file.

function start(){

    {
        local slot = SlotPosition(0, 1);
        _test.assertEqual(slot.slotX, 0);
        _test.assertEqual(slot.slotY, 1);
    }

    {
        local slot = SlotPosition(2, 3, 10, 20, 30);
        _test.assertEqual(slot.slotX, 2);
        _test.assertEqual(slot.slotY, 3);
        _test.assertEqual(slot.x, 10);
        _test.assertEqual(slot.y, 20);
        _test.assertEqual(slot.z, 30);
    }

    { //- SlotPosition
        local first = SlotPosition(3, 4);
        local second = SlotPosition(1, 2);
        local new = first - second;
        _test.assertEqual(new.slotX, 2);
        _test.assertEqual(new.slotY, 2);
    }

    { //+ SlotPosition
        local first = SlotPosition(3, 4);
        local second = SlotPosition(1, 2);
        local new = first + second;
        _test.assertEqual(new.slotX, 4);
        _test.assertEqual(new.slotY, 6);
    }

    { //-= SlotPosition
        local first = SlotPosition(3, 4);
        local second = SlotPosition(1, 2);
        first -= second;
        _test.assertEqual(first.slotX, 2);
        _test.assertEqual(first.slotY, 2);
    }

    { //+= SlotPosition
        local first = SlotPosition(3, 4);
        local second = SlotPosition(1, 2);
        first += second;
        _test.assertEqual(first.slotX, 4);
        _test.assertEqual(first.slotY, 6);
    }

    { //+ Vec3
        local first = SlotPosition(3, 4, 0, 0, 0);
        local second = Vec3(10, 20, 30);
        local new = first + second;
        _test.assertEqual(new.slotX, 3);
        _test.assertEqual(new.slotY, 4);
        _test.assertEqual(new.x, 10);
        _test.assertEqual(new.y, 20);
        _test.assertEqual(new.z, 30);
    }

    { //- Vec3
        local first = SlotPosition(3, 4, 10, 20, 30);
        local second = Vec3(10, 20, 30);
        local new = first - second;
        _test.assertEqual(new.slotX, 3);
        _test.assertEqual(new.slotY, 4);
        _test.assertEqual(new.x, 0);
        _test.assertEqual(new.y, 0);
        _test.assertEqual(new.z, 0);
    }

    { //+= Vec3
        local first = SlotPosition(3, 4, 0, 0, 0);
        local second = Vec3(10, 20, 30);
        first += second;
        _test.assertEqual(first.slotX, 3);
        _test.assertEqual(first.slotY, 4);
        _test.assertEqual(first.x, 10);
        _test.assertEqual(first.y, 20);
        _test.assertEqual(first.z, 30);
    }

    { //-= Vec3
        local first = SlotPosition(3, 4, 10, 20, 30);
        local second = Vec3(10, 20, 30);
        first -= second;
        _test.assertEqual(first.slotX, 3);
        _test.assertEqual(first.slotY, 4);
        _test.assertEqual(first.x, 0);
        _test.assertEqual(first.y, 0);
        _test.assertEqual(first.z, 0);
    }

    { //Copy
        local first = SlotPosition(3, 4, 10, 20, 30);
        local second = first.copy();
        first.x = 100;

        _test.assertFalse(first == second);
        _test.assertEqual(first.x, 100);
        _test.assertEqual(second.x, 10);
    }


    _test.endTest();
}
