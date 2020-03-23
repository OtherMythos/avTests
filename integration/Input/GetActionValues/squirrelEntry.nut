//A test to check that getting the value of actions works as expected.

function start(){

    _input.setActionSets({
        "default" : {
            "Buttons" : {
                "first": "#Action_first"
                "second": "#Action_second"
                "third": "#Action_third"
            }
        }
    });

    local firstHandle = _input.getDigitalActionHandle("first");
    local secondHandle = _input.getDigitalActionHandle("second");
    local thirdHandle = _input.getDigitalActionHandle("third");

    _test.assertFalse(_input.getButtonAction(firstHandle));
    _test.assertFalse(_input.getButtonAction(secondHandle));
    _test.assertFalse(_input.getButtonAction(thirdHandle));

    _input.sendButtonAction(firstHandle, true);
    _test.assertTrue(_input.getButtonAction(firstHandle));
    //Check the other ones haven't gone true.
    _test.assertFalse(_input.getButtonAction(secondHandle));
    _test.assertFalse(_input.getButtonAction(thirdHandle));

    _input.sendButtonAction(secondHandle, true);
    _test.assertTrue(_input.getButtonAction(firstHandle));
    _test.assertTrue(_input.getButtonAction(secondHandle));
    _test.assertFalse(_input.getButtonAction(thirdHandle));

    _input.sendButtonAction(thirdHandle, true);
    _test.assertTrue(_input.getButtonAction(firstHandle));
    _test.assertTrue(_input.getButtonAction(secondHandle));
    _test.assertTrue(_input.getButtonAction(thirdHandle));

    _input.sendButtonAction(firstHandle, false);
    _test.assertFalse(_input.getButtonAction(firstHandle));
    _test.assertTrue(_input.getButtonAction(secondHandle));
    _test.assertTrue(_input.getButtonAction(thirdHandle));

    _input.sendButtonAction(secondHandle, false);
    _input.sendButtonAction(thirdHandle, false);

    _test.assertFalse(_input.getButtonAction(firstHandle));
    _test.assertFalse(_input.getButtonAction(secondHandle));
    _test.assertFalse(_input.getButtonAction(thirdHandle));

    //axis
    _input.sendAxisAction(thirdHandle, 0.5, false);
    //I still need to write the axis retreival.

    _test.endTest();
}
