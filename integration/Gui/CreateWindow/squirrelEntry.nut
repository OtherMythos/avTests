//A test that creates gui windows and then destroys them.

function start(){
    local windows = [];

    for(local i = 0; i < 5; i++){
        _test.assertEqual(_test.gui.getNumWindows(), i);

        local win = _gui.createWindow();
        win.setPosition(600, 200);
        win.setSize(500, 500);
        win.setHidden(false);

        windows.append(win);
    }

    //Start removing windows.
    foreach(c,i in windows){
        _test.assertEqual(_test.gui.getNumWindows(), windows.len() - c);

        _gui.destroy(i);
    }

    //There should be none left.
    _test.assertEqual(_test.gui.getNumWindows(), 0);

    _test.endTest();
}
