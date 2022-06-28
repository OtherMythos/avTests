//A test to check that the current action set of the keyboard can be set correctly.

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


    _input.setActionSetForDevice(_KEYBOARD_INPUT_DEVICE, actionSetFirst);


    _input.mapKeyboardInput(0, FirstButton);
    _input.mapKeyboardInput(0, SecondButton);

    _input.mapKeyboardInput(20, FirstTrigger);
    _input.mapKeyboardInput(20, SecondTrigger);

    _input.mapKeyboardInputAxis(50, 51, 52, 53, FirstStick);
    _input.mapKeyboardInputAxis(50, 51, 52, 53, SecondStick);

    { //Buttons
        _test.assertFalse(_input.getButtonAction(FirstButton, _INPUT_ANY, 0));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, 0));

        _input.sendKeyboardKeyPress(0, true);
        _test.assertTrue(_input.getButtonAction(FirstButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(SecondButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));

        //Changing the action set means the keyboard should send the secondButton now when pressing button 1.
        _input.setActionSetForDevice(_KEYBOARD_INPUT_DEVICE, actionSetSecond);
        _input.sendKeyboardKeyPress(0, true);
        _test.assertTrue(_input.getButtonAction(SecondButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));
    }

    { //Triggers
        _input.setActionSetForDevice(_KEYBOARD_INPUT_DEVICE, actionSetFirst);

        _test.assertEqual(_input.getTriggerAction(FirstTrigger, _INPUT_ANY, 0), 0.0);
        _test.assertEqual(_input.getTriggerAction(SecondTrigger, _INPUT_ANY, 0), 0.0);

        _input.sendKeyboardKeyPress(20, true);
        _test.assertEqual(_input.getTriggerAction(FirstTrigger, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);
        _test.assertEqual(_input.getTriggerAction(SecondTrigger, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);

        _input.setActionSetForDevice(_KEYBOARD_INPUT_DEVICE, actionSetSecond);
        _input.sendKeyboardKeyPress(20, true);
        _test.assertEqual(_input.getTriggerAction(SecondTrigger, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);
    }

    { //Axises
        _input.setActionSetForDevice(_KEYBOARD_INPUT_DEVICE, actionSetFirst);

        _test.assertEqual(_input.getAxisActionX(FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);
        _test.assertEqual(_input.getAxisActionX(SecondStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);

        _input.sendKeyboardKeyPress(50, true);
        _test.assertEqual(_input.getAxisActionX(FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);
        _test.assertEqual(_input.getAxisActionX(SecondStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);


        _input.setActionSetForDevice(_KEYBOARD_INPUT_DEVICE, actionSetSecond);
        _input.sendKeyboardKeyPress(50, true);
        _test.assertEqual(_input.getAxisActionX(SecondStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);


        //Check the y.
        _input.setActionSetForDevice(_KEYBOARD_INPUT_DEVICE, actionSetFirst);
        _test.assertEqual(_input.getAxisActionY(FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);
        _test.assertEqual(_input.getAxisActionY(SecondStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);

        _input.sendKeyboardKeyPress(51, true);
        _test.assertEqual(_input.getAxisActionY(FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);
        _test.assertEqual(_input.getAxisActionY(SecondStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);

        _input.setActionSetForDevice(_KEYBOARD_INPUT_DEVICE, actionSetSecond);
        _input.sendKeyboardKeyPress(51, true);
        _test.assertEqual(_input.getAxisActionY(SecondStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);
    }

    _test.endTest();
}
