//A test to check that action sets can be set using the squirrel api.

function start(){

    _input.setActionSets({
        "actionSetFirst" : {
            "StickPadGyro" : {
                "Move": "#Action_Move",
                "Camera": "#Action_Camera"
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
                "move": "#Action_Move"
            }
        }
    });

    _test.endTest();
}
