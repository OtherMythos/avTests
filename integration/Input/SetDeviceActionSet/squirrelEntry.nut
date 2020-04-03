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

    //When you've got multiple action sets, this should be set upfront.
    //There's no guarantee of which ids will be assigned to which sets. Therefore the default numeric id might not match the intended set.
    _input.setActionSetForDevice(0, actionSetFirst);


    //The engine determines from the handle which set it's a part of. So mapping to the same input is fine.
    _input.mapControllerInput(1, FirstButton);
    _input.mapControllerInput(1, SecondButton);

    _input.mapControllerInput(1, FirstTrigger);
    _input.mapControllerInput(1, SecondTrigger);

    _input.mapControllerInput(0, FirstStick);
    _input.mapControllerInput(0, SecondStick);

    { //Buttons
        _test.assertFalse(_input.getButtonAction(FirstButton, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, 0));

        //0 - device 0, 2 - button input, 1 - button 1, value 1.0 (anything higher than 0 with a button is interpreted as a press).
        _test.input.sendControllerInput(0, 2, 1, 1.0);
        _test.assertTrue(_input.getButtonAction(FirstButton, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, 0));

        //Changing the action set means this controller should send the secondButton now when pressing button 1.
        _input.setActionSetForDevice(0, actionSetSecond);
        _test.input.sendControllerInput(0, 2, 1, 1.0);
        _test.assertTrue(_input.getButtonAction(SecondButton, 0));
    }

    { //Triggers
        _input.setActionSetForDevice(0, actionSetFirst);

        _test.assertEqual(_input.getTriggerAction(FirstTrigger, 0), 0.0);
        _test.assertEqual(_input.getTriggerAction(SecondTrigger, 0), 0.0);

        _test.input.sendControllerInput(0, 1, 1, 1.0);
        _test.assertEqual(_input.getTriggerAction(FirstTrigger, 0), 1.0);
        _test.assertEqual(_input.getTriggerAction(SecondTrigger, 0), 0.0);

        //Changing the action set means this controller should send the secondButton now when pressing button 1.
        _input.setActionSetForDevice(0, actionSetSecond);
        _test.input.sendControllerInput(0, 1, 1, 1.0);
        _test.assertEqual(_input.getTriggerAction(SecondTrigger, 0), 1.0);
    }

    { //Axises
        _input.setActionSetForDevice(0, actionSetFirst);

        _test.assertEqual(_input.getAxisActionX(FirstStick, 0), 0.0);
        _test.assertEqual(_input.getAxisActionX(SecondStick, 0), 0.0);

        _test.input.sendControllerInput(0, 0, 0, 1.0);
        _test.assertEqual(_input.getAxisActionX(FirstStick, 0), 1.0);
        _test.assertEqual(_input.getAxisActionX(SecondStick, 0), 0.0);


        _input.setActionSetForDevice(0, actionSetSecond);
        _test.input.sendControllerInput(0, 0, 0, 1.0);
        _test.assertEqual(_input.getAxisActionX(SecondStick, 0), 1.0);
    }

    _test.endTest();
}
