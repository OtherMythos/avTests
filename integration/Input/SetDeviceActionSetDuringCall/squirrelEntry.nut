/**
This test checks for a bug I found regarding the any device and action set switching.
The any device counts how many have a single button down.
If I had a button down, switched action sets, then released the button, the button would target the wrong data entry in the any device.
This lead to a scenario where old data wasn't being cleared up and the system would roll over the counter as it tried to take away from the 0 value of the new handle.
The solution was to check if that button is mapped or not and then copy the data from the old handle to the new.
*/

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

    //When you've got multiple action sets, this should be set upfront.
    //There's no guarantee of which ids will be assigned to which sets. Therefore the default numeric id might not match the intended set.
    _input.setActionSetForDevice(_ANY_INPUT_DEVICE, actionSetFirst);


    //The engine determines from the handle which set it's a part of. So mapping to the same input is fine.
    _input.mapControllerInput(1, FirstButton);
    _input.mapControllerInput(1, SecondButton);

    _input.mapControllerInput(1, FirstTrigger);
    _input.mapControllerInput(1, SecondTrigger);

    _input.mapControllerInput(0, FirstStick);
    _input.mapControllerInput(0, SecondStick);

    { //Buttons
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));

        //0 - device 0, 2 - button input, 1 - button 1, value 1.0 (anything higher than 0 with a button is interpreted as a press).
        _test.input.sendControllerInput(0, 2, 1, 1.0);
        _test.assertTrue(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));

        //Changing the action set means this controller should send the secondButton now when pressing button 1.
        _input.setActionSetForDevice(0, actionSetSecond);
        //The action with the button held down should switch without me having to do anything.
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
        _test.assertTrue(_input.getButtonAction(SecondButton, _INPUT_ANY, _ANY_INPUT_DEVICE));

        //Release the key should cause the target input to switch.
        _test.input.sendControllerInput(0, 2, 1, 0.0);

        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
    }

    //Set it back, all the numbers should be reset.
    _input.setActionSetForDevice(0, actionSetFirst);

    { //Any device
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, _ANY_INPUT_DEVICE));

        //0 - device 0, 2 - button input, 1 - button 1, value 1.0 (anything higher than 0 with a button is interpreted as a press).
        _test.input.sendControllerInput(0, 2, 1, 1.0);
        _test.assertTrue(_input.getButtonAction(FirstButton, _INPUT_ANY, _ANY_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, _ANY_INPUT_DEVICE));

        //Changing the action set means this controller should send the secondButton now when pressing button 1.
        _input.setActionSetForDevice(0, actionSetSecond);
        //Release the key should cause the target input to switch.
        _test.input.sendControllerInput(0, 2, 1, 0.0);
    }

    _test.endTest();
}
