//A test to check that values can be obtained from the input manager specific to devices.

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

        for(local i = 0; i < _MAX_INPUT_DEVICES; i++){
            _test.assertFalse(_input.getButtonAction(firstHandle, _INPUT_ANY, i));
            _test.assertFalse(_input.getButtonAction(secondHandle, _INPUT_ANY, i));
            _test.assertFalse(_input.getButtonAction(thirdHandle, _INPUT_ANY, i));

            _input.sendButtonAction(firstHandle, i, true);
            _test.assertTrue(_input.getButtonAction(firstHandle, _INPUT_ANY, i));
            //Check the other ones haven't gone true.
            _test.assertFalse(_input.getButtonAction(secondHandle, _INPUT_ANY, i));
            _test.assertFalse(_input.getButtonAction(thirdHandle, _INPUT_ANY, i));

            _input.sendButtonAction(secondHandle, i, true);
            _test.assertTrue(_input.getButtonAction(firstHandle, _INPUT_ANY, i));
            _test.assertTrue(_input.getButtonAction(secondHandle, _INPUT_ANY, i));
            _test.assertFalse(_input.getButtonAction(thirdHandle, _INPUT_ANY, i));

            _input.sendButtonAction(thirdHandle, i, true);
            _test.assertTrue(_input.getButtonAction(firstHandle, _INPUT_ANY, i));
            _test.assertTrue(_input.getButtonAction(secondHandle, _INPUT_ANY, i));
            _test.assertTrue(_input.getButtonAction(thirdHandle, _INPUT_ANY, i));

            _input.sendButtonAction(firstHandle, i, false);
            _test.assertFalse(_input.getButtonAction(firstHandle, _INPUT_ANY, i));
            _test.assertTrue(_input.getButtonAction(secondHandle, _INPUT_ANY, i));
            _test.assertTrue(_input.getButtonAction(thirdHandle, _INPUT_ANY, i));

            _input.sendButtonAction(secondHandle, i, false);
            _input.sendButtonAction(thirdHandle, i, false);

            _test.assertFalse(_input.getButtonAction(firstHandle, _INPUT_ANY, i));
            _test.assertFalse(_input.getButtonAction(secondHandle, _INPUT_ANY, i));
            _test.assertFalse(_input.getButtonAction(thirdHandle, _INPUT_ANY, i));
        }
    }

    //axis
    {
        local firstHandle = _input.getAxisActionHandle("firstStick");
        local secondHandle = _input.getAxisActionHandle("secondStick");
        local thirdHandle = _input.getAxisActionHandle("thirdStick");

        for(local i = 0; i < _MAX_INPUT_DEVICES; i++){
            _test.assertEqual(0.0, _input.getAxisActionX(firstHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionY(firstHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionX(secondHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionY(secondHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionX(thirdHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionY(thirdHandle, _INPUT_ANY, i));

            _input.sendAxisAction(firstHandle, i, 10.123, true);
            _input.sendAxisAction(firstHandle, i, 20.123, false);

            _test.assertEqual(10.123, _input.getAxisActionX(firstHandle, _INPUT_ANY, i));
            _test.assertEqual(20.123, _input.getAxisActionY(firstHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionX(secondHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionY(secondHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionX(thirdHandle, _INPUT_ANY, i));
            _test.assertEqual(0.0, _input.getAxisActionY(thirdHandle, _INPUT_ANY, i));

            _input.sendAxisAction(firstHandle, i, 30.0, true);
            _test.assertEqual(30.0, _input.getAxisActionX(firstHandle, _INPUT_ANY, i));
            _test.assertEqual(20.123, _input.getAxisActionY(firstHandle, _INPUT_ANY, i));

            local count = 0.0;
            foreach(h in [firstHandle, secondHandle, thirdHandle]){
                _input.sendAxisAction(h, i, count, true);
                count += 5.0;
                _input.sendAxisAction(h, i, count, false);
                count += 5.0;
            }

            count = 0.0;
            foreach(h in [firstHandle, secondHandle, thirdHandle]){
                _test.assertEqual(count, _input.getAxisActionX(h, i));
                count += 5.0;
                _test.assertEqual(count, _input.getAxisActionY(h, i));
                count += 5.0;
            }
        }
    }

    //Trigger
    {
        local firstHandle = _input.getTriggerActionHandle("firstTrigger");
        local secondHandle = _input.getTriggerActionHandle("secondTrigger");
        local thirdHandle = _input.getTriggerActionHandle("thirdTrigger");

        for(local i = 0; i < _MAX_INPUT_DEVICES; i++){
            _test.assertEqual(_input.getTriggerAction(firstHandle, _INPUT_ANY, i), 0.0);
            _input.sendTriggerAction(firstHandle, i, 20.0);
            _test.assertEqual(_input.getTriggerAction(firstHandle, _INPUT_ANY, i), 20.0);

            _input.sendTriggerAction(secondHandle, i, 30.0);
            _test.assertEqual(_input.getTriggerAction(firstHandle, _INPUT_ANY, i), 20.0);
            _test.assertEqual(_input.getTriggerAction(secondHandle, _INPUT_ANY, i), 30.0);
            _test.assertEqual(_input.getTriggerAction(thirdHandle, _INPUT_ANY, i), 0.0);

            _input.sendTriggerAction(thirdHandle, i, 40.0);
            _test.assertEqual(_input.getTriggerAction(firstHandle, _INPUT_ANY, i), 20.0);
            _test.assertEqual(_input.getTriggerAction(secondHandle, _INPUT_ANY, i), 30.0);
            _test.assertEqual(_input.getTriggerAction(thirdHandle, _INPUT_ANY, i), 40.0);
        }
    }

    _test.endTest();
}
