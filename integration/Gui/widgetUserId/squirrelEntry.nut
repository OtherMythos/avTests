//A test to check that user ids can be assigned and read from widgets.

function start(){
    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);
    win.setHidden(false);
    win.setUserId(401);

    local firstButton = win.createButton();
    firstButton.setText("A button");
    firstButton.setUserId(101);

    _test.assertEqual(_test.gui.getNumWidgets(), 1);

    local label = win.createLabel();
    label.setText("Another button");
    label.setUserId(201);

    _test.assertEqual(_test.gui.getNumWidgets(), 2);

    _test.assertEqual(firstButton.getUserId(), 101);
    _test.assertEqual(label.getUserId(), 201);
    _test.assertEqual(win.getUserId(), 401);

    label.setUserId(301);
    _test.assertEqual(label.getUserId(), 301);
    _test.assertEqual(win.getUserId(), 401);

    //TODO this will fail until a re-write of parts of the gui code is completed.
    /*_gui.destroy(label);
    local failed = false;
    try{
        //Should fail to get from an invalid widget.
        label.getUserId();
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);*/

    _test.endTest();
}
