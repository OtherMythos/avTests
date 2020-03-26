//A test to check that mapping actions works as expected.

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

    _input.mapControllerInput(1, _input.getButtonActionHandle("Jump"));

    _test.endTest();
}
