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
        _test.assertEqual(_gui.getNumWindows(), i);

        local win = _gui.createWindow(windowIds[i]);
        win.setPosition(600, 200);
        win.setSize(500, 500);
        win.setHidden(false);

        windows.append(win);
    }

    _test.assertEqual(_gui.getNumWindows(), 5);
    //Check each window claims to have a query id present in the list.
    while(windowIds.len() > 0){
        local queryId = windows[0].getQueryName();
        _test.assertTrue(windowIds.find(queryId) != null);
        _test.assertTrue(queryId == windowIds[0]);
        windowIds.remove(0);
        windows.remove(0);
    }

    //Destroy all the remaining windows.
    while(_gui.getNumWindows() != 0){
        _gui.destroy(_gui.getWindowForIdx(0));
    }
    _test.assertEqual(_gui.getNumWindows(), 0);

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
    _test.assertEqual(_gui.getNumWindows(), 3);

    _test.endTest();
}
