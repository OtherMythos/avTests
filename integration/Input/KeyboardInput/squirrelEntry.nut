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
        _test.assertFalse(_input.getButtonAction(::FirstButton));
        _test.assertFalse(_input.getButtonAction(::SecondButton));

        _test.input.sendKeyboardKeyPress(0, true);
        _test.assertTrue(_input.getButtonAction(::FirstButton));
        _test.assertFalse(_input.getButtonAction(::SecondButton));

        _test.input.sendKeyboardKeyPress(10, true);
        _test.assertTrue(_input.getButtonAction(::FirstButton));
        _test.assertTrue(_input.getButtonAction(::SecondButton));

        _test.input.sendKeyboardKeyPress(0, false);
        _test.input.sendKeyboardKeyPress(10, false);
        _test.assertFalse(_input.getButtonAction(::FirstButton));
        _test.assertFalse(_input.getButtonAction(::SecondButton));
    }

    { //Triggers
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger), 0.0);

        _test.input.sendKeyboardKeyPress(20, true);
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger), 1.0);

        _test.input.sendKeyboardKeyPress(20, false);
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger), 0.0);
    }

    { //Axises
        _test.assertEqual(_input.getAxisActionX(::FirstStick), 0.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick), 0.0);

        _test.input.sendKeyboardKeyPress(50, true);
        _test.assertEqual(_input.getAxisActionX(::FirstStick), 1.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick), 0.0);
        _test.input.sendKeyboardKeyPress(50, false);
        _test.assertEqual(_input.getAxisActionX(::FirstStick), 0.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick), 0.0);

        _test.input.sendKeyboardKeyPress(52, true);
        _test.assertEqual(_input.getAxisActionX(::FirstStick), -1.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick), 0.0);

        _test.input.sendKeyboardKeyPress(53, true);
        _test.assertEqual(_input.getAxisActionX(::FirstStick), -1.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick), -1.0);
        _test.input.sendKeyboardKeyPress(52, false);
        _test.input.sendKeyboardKeyPress(53, false);

        _test.input.sendKeyboardKeyPress(50, true);
        _test.input.sendKeyboardKeyPress(51, true);
        _test.assertEqual(_input.getAxisActionY(::FirstStick), 1.0);
        _test.assertEqual(_input.getAxisActionY(::FirstStick), 1.0);
    }

    _test.endTest();
}
