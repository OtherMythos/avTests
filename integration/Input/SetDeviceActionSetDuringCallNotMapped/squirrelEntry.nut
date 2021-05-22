//A test to check that action sets can be set using the squirrel api.

function start(){

    _input.setActionSets({
        "FirstSet" : {
            "StickPadGyro" : {
                "FirstStick": "#Action_FirstStick",
            },
            "AnalogTrigger":{
                "FirstTrigger":"#Action_FirstTrigger"
            },
            "Buttons" : {
                "FirstButton": "#Action_FirstButton"
            }
        },
        "SecondSet" : {
            "StickPadGyro" : {
                "SecondStick": "#Action_SecondStick",
            },
            "AnalogTrigger":{
                "SecondTrigger":"#Action_SecondTrigger"
            },
            "Buttons" : {
                "SecondButton": "#Action_SecondButton"
            }
        }
    });

    local names = _input.getActionSetNames();
    _test.assertEqual(names.len(), 2);

    local actionSetFirst = _input.getActionSetHandle("FirstSet");
    local actionSetSecond = _input.getActionSetHandle("SecondSet");

    local FirstButton = _input.getButtonActionHandle("FirstButton");
    local FirstTrigger = _input.getTriggerActionHandle("FirstTrigger");
    local FirstStick = _input.getAxisActionHandle("FirstStick");

    local SecondButton = _input.getButtonActionHandle("SecondButton");
    local SecondTrigger = _input.getTriggerActionHandle("SecondTrigger");
    local SecondStick = _input.getAxisActionHandle("SecondStick");

    _input.setActionSetForDevice(_ANY_INPUT_DEVICE, actionSetFirst);


    //The engine determines from the handle which set it's a part of. So mapping to the same input is fine.
    _input.mapControllerInput(1, FirstButton);
    _input.mapControllerInput(2, SecondButton);

    { //Buttons
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));

        //0 - device 0, 2 - button input, 1 - button 1, value 1.0 (anything higher than 0 with a button is interpreted as a press).
        _test.input.sendControllerInput(0, 2, 1, 1.0);
        _test.assertTrue(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));

        _input.setActionSetForDevice(0, actionSetSecond);
        //Device 0 should report not being set for either, as the input has moved to a different set.
        //If the input is not mapped, it gets removed on the old one, and discarded.
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, _ANY_INPUT_DEVICE));

        //Release the key should cause the target input to switch.
        _test.input.sendControllerInput(0, 2, 1, 0.0);

        //All inputs should have gone.
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
    }

    //Can I press an input, switch to unmapped, switch back?
    _input.setActionSetForDevice(_ANY_INPUT_DEVICE, actionSetFirst);
    print("second bit");

    { //Buttons
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));

        //0 - device 0, 2 - button input, 1 - button 1, value 1.0 (anything higher than 0 with a button is interpreted as a press).
        _test.input.sendControllerInput(0, 2, 1, 1.0);
        _test.assertTrue(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));

        _input.setActionSetForDevice(0, actionSetSecond);
        //Device 0 should report not being set for either, as the input has moved to a different set.
        //If the input is not mapped, it gets removed on the old one, and discarded.
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, _ANY_INPUT_DEVICE));

        //Switch back without releasing the button.
        _input.setActionSetForDevice(0, actionSetFirst);

        //Release the button.
        _test.input.sendControllerInput(0, 2, 1, 0.0);

        //All inputs should have gone.
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
    }



    _test.endTest();

}
