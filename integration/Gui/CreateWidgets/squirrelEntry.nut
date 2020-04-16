//A test that creates and destroys widgets within a window.

function start(){
    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);
    win.setHidden(false);

    local firstButton = win.createButton();
    firstButton.setText("A button");

    _test.assertEqual(_test.gui.getNumWidgets(), 1);

    local secondButton = win.createButton();
    secondButton.setText("Another button");

    _test.assertEqual(_test.gui.getNumWidgets(), 2);

    _gui.destroy(firstButton);

    _test.assertEqual(_test.gui.getNumWidgets(), 1);

    //Check widgets can be recreated after one has been deleted.
    local recreateButton = win.createButton();
    recreateButton.setText("A button");
    _test.assertEqual(_test.gui.getNumWidgets(), 2);

    _gui.destroy(secondButton);
    _gui.destroy(recreateButton);

    _test.assertEqual(_test.gui.getNumWidgets(), 0);

    _test.endTest();
}
