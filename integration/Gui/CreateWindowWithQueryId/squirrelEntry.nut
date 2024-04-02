//A test that creates gui windows, assigns them query ids and checks the ids can be found correctly.

function start(){
    local windows = [];
    local windowIds = [
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
    ];

    for(local i = 0; i < 5; i++){
        _test.assertEqual(_test.gui.getNumWindows(), i);

        local win = _gui.createWindow(windowIds[i]);
        win.setPosition(600, 200);
        win.setSize(500, 500);
        win.setHidden(false);

        windows.append(win);
    }

    _test.assertEqual(_test.gui.getNumWindows(), 5);
    //Check each window claims to have a query id present in the list.
    while(windowIds.len() > 0){
        _test.assertTrue(windowIds.find(windows[0].getQueryName()) != null);
        windowIds.remove(0);
        windows.remove(0);
    }

    //Ensure child windows can also be given ids.
    //Create a window without any id.
    local win = _gui.createWindow();
    local child = win.createWindow("childWindow");
    //Check you can create another window without an id.
    local childSecond = win.createWindow();
    local found = false;
    for(local i = 0; i < _gui.getNumWindows(); i++){
        local win = _gui.getWindowForIdx(i);
        if(win.getQueryName() == "childWindow") found = true;
    }
    _test.assertTrue(found);

    _test.endTest();
}
