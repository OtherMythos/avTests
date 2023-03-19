//A test which checks the ColourValue data type.

function start(){

    {
        local colour = ColourValue(1, 0, 0, 1);

        _test.assertEqual(colour.r, 1);
        _test.assertEqual(colour.g, 0);
        _test.assertEqual(colour.b, 0);
        _test.assertEqual(colour.a, 1);
    }


    { //Assignment
        local colour = ColourValue(1, 0, 0, 1);
        local other = null;
        other = colour;

        _test.assertEqual(other.r, 1);
        _test.assertEqual(other.g, 0);
        _test.assertEqual(other.b, 0);
        _test.assertEqual(other.a, 1);
    }

    { //Assignment
        local colour = ColourValue(1, 0, 0, 1);
        local other = ColourValue(0, 1, 0, 0);
        other = colour;

        _test.assertEqual(other.r, 1);
        _test.assertEqual(other.g, 0);
        _test.assertEqual(other.b, 0);
        _test.assertEqual(other.a, 1);
    }

    { //Addition single number +=
        local colour = ColourValue(1, 0, 0, 1);
        colour += 0.1;

        _test.assertEqual(colour.r, 1.1);
        _test.assertEqual(colour.g, 0.1);
        _test.assertEqual(colour.b, 0.1);
        _test.assertEqual(colour.a, 1.1);
    }

    { //Addition ColourValue single number +=
        local colour = ColourValue(1, 0, 0, 1);
        colour += ColourValue(0.1, 0, 0, 0.1);

        _test.assertEqual(colour.r, 1.1);
        _test.assertEqual(colour.g, 0);
        _test.assertEqual(colour.b, 0);
        _test.assertEqual(colour.a, 1.1);
    }

    { //Addition single number
        local colour = ColourValue(1, 0, 0, 1);
        colour = colour + 0.1;

        _test.assertEqual(colour.r, 1.1);
        _test.assertEqual(colour.g, 0.1);
        _test.assertEqual(colour.b, 0.1);
        _test.assertEqual(colour.a, 1.1);

        //Check that the value is not changed without the assignment.
        local secondVal = ColourValue(1, 0, 0, 1);
        secondVal + 0.1;
        _test.assertEqual(secondVal.r, 1);
        _test.assertEqual(secondVal.g, 0);
        _test.assertEqual(secondVal.b, 0);
        _test.assertEqual(secondVal.a, 1);
    }

    { //Addition ColourValue
        local colour = ColourValue(0.1, 0.1, 0.1, 0.1);
        colour = colour + ColourValue(0.1, 0.2, 0.3, 0.4);

        _test.assertEqual(colour.r, 0.2);
        _test.assertEqual(colour.g, 0.3);
        _test.assertEqual(colour.b, 0.4);
        _test.assertEqual(colour.a, 0.5);
    }

    //Minus

    { //Addition single number -=
        local colour = ColourValue(1, 1, 1, 1);
        colour -= 0.1;

        _test.assertEqual(colour.r, 0.9);
        _test.assertEqual(colour.g, 0.9);
        _test.assertEqual(colour.b, 0.9);
        _test.assertEqual(colour.a, 0.9);
    }

    { //Addition ColourValue single number -=
        local colour = ColourValue(1, 1, 1, 1);
        colour -= ColourValue(0.1, 0.2, 0.3, 0.4);

        _test.assertEqual(colour.r, 0.9);
        _test.assertEqual(colour.g, 0.8);
        _test.assertEqual(colour.b, 0.7);
        _test.assertEqual(colour.a, 0.6);
    }

    { //Subtraction single number
        local colour = ColourValue(1, 1, 1, 1);
        colour = colour - 0.1;

        _test.assertEqual(colour.r, 0.9);
        _test.assertEqual(colour.g, 0.9);
        _test.assertEqual(colour.b, 0.9);
        _test.assertEqual(colour.a, 0.9);

        local secondColour = ColourValue(1, 1, 1, 1);
        secondColour - 0.1;

        _test.assertEqual(secondColour.r, 1);
        _test.assertEqual(secondColour.g, 1);
        _test.assertEqual(secondColour.b, 1);
        _test.assertEqual(secondColour.a, 1);
    }

    { //Subtraction ColourValue
        local colour = ColourValue(1, 1, 1, 1);
        colour = colour - ColourValue(0.1, 0.2, 0.3, 0.4);

        _test.assertEqual(colour.r, 0.9);
        _test.assertEqual(colour.g, 0.8);
        _test.assertEqual(colour.b, 0.7);
        _test.assertEqual(colour.a, 0.6);


        local secondColour = ColourValue(1, 1, 1, 1);
        secondColour - ColourValue(0.1, 0.2, 0.3, 0.4);

        _test.assertEqual(secondColour.r, 1);
        _test.assertEqual(secondColour.g, 1);
        _test.assertEqual(secondColour.b, 1);
        _test.assertEqual(secondColour.a, 1);
    }

    //Multiply

    { //Multiply single number *=
        local secondColour = ColourValue(0.1, 0.1, 0.1, 0.1);
        secondColour *= 2;

        _test.assertEqual(secondColour.r, 0.2);
        _test.assertEqual(secondColour.g, 0.2);
        _test.assertEqual(secondColour.b, 0.2);
        _test.assertEqual(secondColour.a, 0.2);
    }

    { //Multiply ColourValue *=
        local secondColour = ColourValue(0.1, 0.1, 0.1, 0.1);
        secondColour *= ColourValue(2, 2, 2, 2);

        _test.assertEqual(secondColour.r, 0.2);
        _test.assertEqual(secondColour.g, 0.2);
        _test.assertEqual(secondColour.b, 0.2);
        _test.assertEqual(secondColour.a, 0.2);
    }

    { //ColourValue *
        local secondColour = ColourValue(0.1, 0.1, 0.1, 0.1);
        secondColour = secondColour * 2;

        _test.assertEqual(secondColour.r, 0.2);
        _test.assertEqual(secondColour.g, 0.2);
        _test.assertEqual(secondColour.b, 0.2);
        _test.assertEqual(secondColour.a, 0.2);
    }

    //Divide

    { //Divide single number *=
        local secondColour = ColourValue(1, 1, 1, 1);
        secondColour /= 2;

        _test.assertEqual(secondColour.r, 0.5);
        _test.assertEqual(secondColour.g, 0.5);
        _test.assertEqual(secondColour.b, 0.5);
        _test.assertEqual(secondColour.a, 0.5);
    }

    { //ColourValue /
        local secondColour = ColourValue(1, 1, 1, 1);
        secondColour = secondColour / 2;

        _test.assertEqual(secondColour.r, 0.5);
        _test.assertEqual(secondColour.g, 0.5);
        _test.assertEqual(secondColour.b, 0.5);
        _test.assertEqual(secondColour.a, 0.5);
    }

    //toString
    {
        local secondColour = ColourValue(1, 1, 1, 1);

        _test.assertEqual(secondColour.tostring(), "ColourValue(1, 1, 1, 1)");
    }

    //Copy
    {
        local first = ColourValue(1, 1, 1, 1);
        local second = first.copy();
        second.r = 0.5;

        _test.assertFalse(first == second);
        _test.assertEqual(second.r, 0.5);
        _test.assertEqual(first.r, 1);
    }

    //Not including the alpha channel.
    {
        local colour = ColourValue(1, 0, 1);

        _test.assertEqual(colour.r, 1);
        _test.assertEqual(colour.g, 0);
        _test.assertEqual(colour.b, 1);
        _test.assertEqual(colour.a, 1);
    }

    _test.endTest();
}
