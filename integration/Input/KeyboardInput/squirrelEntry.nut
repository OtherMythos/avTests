//A test to check that keyboard input can be used to set values in the input manager.

function start(){

    _input.setActionSets({
        "first" : {
            "StickPadGyro" : {
                "FirstAxis": "#first_axis",
            },
            "AnalogTrigger":{
                "FirstTrigger":"#first_trigger"
            },
            "Buttons" : {
                "FirstButton": "#first_button"
                "SecondButton": "#second_button"
            }
        }
    });

    ::FirstButton <- _input.getButtonActionHandle("FirstButton");
    ::SecondButton <- _input.getButtonActionHandle("SecondButton");
    ::FirstTrigger <- _input.getTriggerActionHandle("FirstTrigger");
    ::FirstStick <- _input.getAxisActionHandle("FirstAxis");

    //In this example it doesn't matter what id is used.
    _input.mapKeyboardInput(0, ::FirstButton);
    _input.mapKeyboardInput(10, ::SecondButton);

    _input.mapKeyboardInput(20, ::FirstTrigger);

    _input.mapKeyboardInputAxis(50, 51, 52, 53, ::FirstStick);

    { //Buttons
        _test.assertFalse(_input.getButtonAction(::FirstButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(::SecondButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));

        _input.sendKeyboardKeyPress(0, true);
        _test.assertTrue(_input.getButtonAction(::FirstButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(::SecondButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));

        _input.sendKeyboardKeyPress(10, true);
        _test.assertTrue(_input.getButtonAction(::FirstButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));
        _test.assertTrue(_input.getButtonAction(::SecondButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));

        _input.sendKeyboardKeyPress(0, false);
        _input.sendKeyboardKeyPress(10, false);
        _test.assertFalse(_input.getButtonAction(::FirstButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));
        _test.assertFalse(_input.getButtonAction(::SecondButton, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE));
    }

    { //Triggers
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);

        _input.sendKeyboardKeyPress(20, true);
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);

        _input.sendKeyboardKeyPress(20, false);
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);
    }

    { //Axises
        _test.assertEqual(_input.getAxisActionX(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);

        _input.sendKeyboardKeyPress(50, true);
        _test.assertEqual(_input.getAxisActionX(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);
        _input.sendKeyboardKeyPress(50, false);
        _test.assertEqual(_input.getAxisActionX(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);

        _input.sendKeyboardKeyPress(52, true);
        _test.assertEqual(_input.getAxisActionX(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), -1.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 0.0);

        _input.sendKeyboardKeyPress(53, true);
        _test.assertEqual(_input.getAxisActionX(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), -1.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), -1.0);
        _input.sendKeyboardKeyPress(52, false);
        _input.sendKeyboardKeyPress(53, false);

        _input.sendKeyboardKeyPress(50, true);
        _input.sendKeyboardKeyPress(51, true);
        _test.assertEqual(_input.getAxisActionY(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick, _INPUT_ANY, _KEYBOARD_INPUT_DEVICE), 1.0);
    }

    _test.endTest();
}
