//A test that assigns callback functions to widgets and checks they're called appropriately.

::count <- 0;

function callbackFunction(widget, action){
    ::count += action;
}

function secondCallbackFunction(widget, action){
    ::count -= action;
}

function start(){
    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);
    win.setHidden(false);

    local firstButton = win.createButton();
    firstButton.setText("A button");
    firstButton.attachListener(callbackFunction);

    _test.assertEqual(0, ::count);
    //Really here the number would be an enum rather than just a plain value.
    _test.gui.callListener(firstButton, 1);
    _test.assertEqual(1, ::count);

    local expectedVal = 1;
    for(local i = 0; i < 5; i++){
        _test.gui.callListener(firstButton, i);
        expectedVal += i;
    }

    _test.assertEqual(expectedVal, count);


    firstButton.attachListener(secondCallbackFunction);
    _test.gui.callListener(firstButton, 1);
    _test.assertEqual(expectedVal - 1, count);

    firstButton.detachListener();
    _test.gui.callListener(firstButton, 1);

    //
    //For part 2 reset count, assign the function to two buttons and press them alterately.
    ::count = 0;
    local secondButton = win.createButton();
    secondButton.setText("Second button");


    firstButton.attachListener(callbackFunction);
    secondButton.attachListener(secondCallbackFunction);

    for(local i = 0; i < 5; i++){
        _test.assertEqual(count, 0);
        _test.gui.callListener(firstButton, 1);
        _test.assertEqual(count, 1);
        _test.gui.callListener(secondButton, 1);
        _test.assertEqual(count, 0);
    }

    _test.endTest();
}
