//A test that checks functions persist when they're attached to a button.

::count <- 0;

function start(){
    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);
    win.setHidden(false);

    local firstButton = win.createButton();
    firstButton.setText("A button");

    local func = function(widget, action){
        ::count++;
    }

    firstButton.attachListener(func);

    _test.assertEqual(0, ::count);
    _test.gui.callListener(firstButton, 1);
    _test.assertEqual(1, ::count);

    func = 0; //The function should now be deleted.

    _test.gui.callListener(firstButton, 1);
    _test.assertEqual(2, ::count);

    firstButton.detachListener();

    _test.endTest();
}
