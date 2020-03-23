//A test to check that action sets can be set using the squirrel api.

function start(){

    _input.setActionSets({
        "actionSetFirst" : {
            "StickPadGyro" : {
                "Move": "#Action_Move",
                "Camera": "#Action_Camera"
            },
            "AnalogTrigger":{
                "Reload":"#Action_Reload"
            },
            "Buttons" : {
                "Jump": "#Action_Jump"
            }
        },
        "menuActionSet" : {
            "StickPadGyro" : {
            },
            "Buttons" : {
                "Menu_Up": "#Menu_Up"
            }
        },
        "default" : {
            "StickPadGyro" : {
                "defaultMove": "#Action_Move"
            }
        }
    });

    //::moveHandle <- _input.getDigitalActionHandle("Move");
    //::jumpHandle <- _input.getDigitalActionHandle("Jump");

    //::acceptHandle <- _input.getButtonActionHandle("Start");
    local names = _input.getActionSetNames();
    _test.assertEqual(names.len(), 3); //Three action sets.
    _test.assertNotEqual(names.find("actionSetFirst"), null);
    _test.assertNotEqual(names.find("menuActionSet"), null);
    _test.assertNotEqual(names.find("default"), null);

    local actionSetFirst = _input.getActionSetHandle("actionSetFirst");
    local menuActionSet = _input.getActionSetHandle("menuActionSet");
    local defaultSet = _input.getActionSetHandle("default");

    {
        local stickList = _input.getActionNamesForSet(actionSetFirst, 0);
        _test.assertEqual(stickList.len(), 2);
        _test.assertNotEqual(stickList.find("Move"), null);
        _test.assertNotEqual(stickList.find("Camera"), null);

        local triggerList = _input.getActionNamesForSet(actionSetFirst, 1);
        _test.assertEqual(triggerList.len(), 1);
        _test.assertNotEqual(triggerList.find("Reload"), null);

        local ButtonList = _input.getActionNamesForSet(actionSetFirst, 2);
        _test.assertEqual(ButtonList.len(), 1);
        _test.assertNotEqual(ButtonList.find("Jump"), null);
    }

    {
        local stickList = _input.getActionNamesForSet(menuActionSet, 0);
        _test.assertEqual(stickList.len(), 0);

        local triggerList = _input.getActionNamesForSet(menuActionSet, 1);
        _test.assertEqual(triggerList.len(), 0);

        local ButtonList = _input.getActionNamesForSet(menuActionSet, 2);
        _test.assertEqual(ButtonList.len(), 1);
        _test.assertNotEqual(ButtonList.find("Menu_Up"), null);
    }

    {
        local stickList = _input.getActionNamesForSet(defaultSet, 0);
        _test.assertEqual(stickList.len(), 1);
        _test.assertNotEqual(stickList.find("defaultMove"), null);

        local triggerList = _input.getActionNamesForSet(defaultSet, 1);
        _test.assertEqual(triggerList.len(), 0);

        local ButtonList = _input.getActionNamesForSet(defaultSet, 2);
        _test.assertEqual(ButtonList.len(), 0);
    }

    //By this point the original set was parsed and loaded succesfully.
    //Now to replace it with a new group of sets and check the old ones are removed, and these are loaded correctly.
    //After a set change the old handles become invalid, and their use produces unknown effects.
    _input.setActionSets({
        "newDefault" : {
            "StickPadGyro" : {
                "newDefaultMove": "#Action_Move"
            },
            "AnalogTrigger" : {
                "newAnalogTrigger": "#Action_Trigger"
            },
            "Buttons" : {
                "newButton": "#Action_Buttons"
            }
        }
    });

    names = _input.getActionSetNames();
    _test.assertEqual(names.len(), 1);
    _test.assertNotEqual(names.find("newDefault"), null);

    local newDefaultSet = _input.getActionSetHandle("newDefault");
    {
        local stickList = _input.getActionNamesForSet(newDefaultSet, 0);
        _test.assertEqual(stickList.len(), 1);
        _test.assertNotEqual(stickList.find("newDefaultMove"), null);

        local triggerList = _input.getActionNamesForSet(newDefaultSet, 1);
        _test.assertEqual(triggerList.len(), 1);
        _test.assertNotEqual(triggerList.find("newAnalogTrigger"), null);

        local buttonList = _input.getActionNamesForSet(newDefaultSet, 2);
        _test.assertEqual(buttonList.len(), 1);
        _test.assertNotEqual(buttonList.find("newButton"), null);
    }

    _test.endTest();
}
