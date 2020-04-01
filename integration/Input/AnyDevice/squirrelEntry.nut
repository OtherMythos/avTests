//The any device is an input device where all inputs are sent to.
//This is done to allow better support for those who don't really care about multiple controllers.
//This test checks the various inputs of the any device.

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
        //Inputs which don't specify a device default to the any device.
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

        //Now do a combination of buttons of different devices, and keys.
        _test.input.sendKeyboardKeyPress(0, true);
        _test.assertTrue(_input.getButtonAction(::FirstButton));
        _test.input.sendButtonAction(::FirstButton, 0, true);
        _test.assertTrue(_input.getButtonAction(::FirstButton)); //Should still be true
        _test.input.sendKeyboardKeyPress(0, false);
        _test.assertTrue(_input.getButtonAction(::FirstButton)); //Release the key, should still be true as the other one is down.
        _test.input.sendButtonAction(::FirstButton, 0, false);
        _test.assertFalse(_input.getButtonAction(::FirstButton)); //Now they're all released so should be false.

        //Go through all the controllers, setting the buttons, releasing them, checking as long as one is down it returns true.
        _test.assertFalse(_input.getButtonAction(::SecondButton));
        for(local i = 0; i < _MAX_INPUT_DEVICES; i++){
            _test.input.sendButtonAction(::SecondButton, 0, true);
            _test.assertTrue(_input.getButtonAction(::SecondButton));
        }
        for(local i = 0; i < _MAX_INPUT_DEVICES; i++){
            _test.assertTrue(_input.getButtonAction(::SecondButton));
            _test.input.sendButtonAction(::SecondButton, 0, false);
        }
        _test.assertFalse(_input.getButtonAction(::FirstButton)); //Now all the buttons are released, it should be false again.

    }


    { //Triggers
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger), 0.0);

        _test.input.sendKeyboardKeyPress(20, true);
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger), 1.0);
        _test.input.sendTriggerAction(::FirstTrigger, 0, 0.5);
        _test.assertEqual(_input.getTriggerAction(::FirstTrigger), 0.5);
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
