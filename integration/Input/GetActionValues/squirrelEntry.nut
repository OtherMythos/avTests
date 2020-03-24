//A test to check that getting the value of actions works as expected.

function start(){

    _input.setActionSets({
        "default" : {
            "Buttons" : {
                "firstButton": "#Action_first",
                "secondButton": "#Action_second",
                "thirdButton": "#Action_third"
            },
            "AnalogTrigger":{
                "firstTrigger":"#Action_first",
                "secondTrigger":"#Action_first",
                "thirdTrigger":"#Action_first"
            },
            "StickPadGyro" : {
                "firstStick":"#Action_first",
                "secondStick":"#Action_first",
                "thirdStick":"#Action_first"
            }
        }
    });

    {
        local firstHandle = _input.getButtonActionHandle("firstButton");
        local secondHandle = _input.getButtonActionHandle("secondButton");
        local thirdHandle = _input.getButtonActionHandle("thirdButton");

        _test.assertFalse(_input.getButtonAction(firstHandle));
        _test.assertFalse(_input.getButtonAction(secondHandle));
        _test.assertFalse(_input.getButtonAction(thirdHandle));

        _test.input.sendButtonAction(firstHandle, true);
        _test.assertTrue(_input.getButtonAction(firstHandle));
        //Check the other ones haven't gone true.
        _test.assertFalse(_input.getButtonAction(secondHandle));
        _test.assertFalse(_input.getButtonAction(thirdHandle));

        _test.input.sendButtonAction(secondHandle, true);
        _test.assertTrue(_input.getButtonAction(firstHandle));
        _test.assertTrue(_input.getButtonAction(secondHandle));
        _test.assertFalse(_input.getButtonAction(thirdHandle));

        _test.input.sendButtonAction(thirdHandle, true);
        _test.assertTrue(_input.getButtonAction(firstHandle));
        _test.assertTrue(_input.getButtonAction(secondHandle));
        _test.assertTrue(_input.getButtonAction(thirdHandle));

        _test.input.sendButtonAction(firstHandle, false);
        _test.assertFalse(_input.getButtonAction(firstHandle));
        _test.assertTrue(_input.getButtonAction(secondHandle));
        _test.assertTrue(_input.getButtonAction(thirdHandle));

        _test.input.sendButtonAction(secondHandle, false);
        _test.input.sendButtonAction(thirdHandle, false);

        _test.assertFalse(_input.getButtonAction(firstHandle));
        _test.assertFalse(_input.getButtonAction(secondHandle));
        _test.assertFalse(_input.getButtonAction(thirdHandle));
    }

    //axis
    {
        local firstHandle = _input.getAxisActionHandle("firstStick");
        local secondHandle = _input.getAxisActionHandle("secondStick");
        local thirdHandle = _input.getAxisActionHandle("thirdStick");

        _test.assertEqual(0.0, _input.getAxisActionX(firstHandle));
        _test.assertEqual(0.0, _input.getAxisActionY(firstHandle));
        _test.assertEqual(0.0, _input.getAxisActionX(secondHandle));
        _test.assertEqual(0.0, _input.getAxisActionY(secondHandle));
        _test.assertEqual(0.0, _input.getAxisActionX(thirdHandle));
        _test.assertEqual(0.0, _input.getAxisActionY(thirdHandle));

        _test.input.sendAxisAction(firstHandle, 10.123, true);
        _test.input.sendAxisAction(firstHandle, 20.123, false);

        _test.assertEqual(10.123, _input.getAxisActionX(firstHandle));
        _test.assertEqual(20.123, _input.getAxisActionY(firstHandle));
        _test.assertEqual(0.0, _input.getAxisActionX(secondHandle));
        _test.assertEqual(0.0, _input.getAxisActionY(secondHandle));
        _test.assertEqual(0.0, _input.getAxisActionX(thirdHandle));
        _test.assertEqual(0.0, _input.getAxisActionY(thirdHandle));
    }

    //Trigger
    {
        local firstHandle = _input.getTriggerActionHandle("firstTrigger");
        local secondHandle = _input.getTriggerActionHandle("secondTrigger");
        local thirdHandle = _input.getTriggerActionHandle("thirdTrigger");

        local val = _input.getTriggerAction(firstHandle);
        print(val)
    }

    _test.endTest();
}
