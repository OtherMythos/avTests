//A test that checks a widget's children can be interated and checked as expected.

function start(){
    local win = _gui.createWindow();
    local count = 0;

    local entries = [
        "first",
        "second",
        "third"
    ];
    local layout = _gui.createLayoutLine();
    foreach(i in entries){
        local button = win.createButton();
        button.setText(i);
        layout.addCell(button);
    }
    layout.layout();
    //Create a window as parent of a window and give it some buttons.
    local parentWindow = win.createWindow("parentWin");
    foreach(i in entries){
        local button = parentWindow.createButton();
        button.setText(count.tostring());
        //_test.assertEqual(button.getNumChildren(), 0);
        count++;
    }

    _test.assertEqual(win.getNumChildren(), entries.len());
    for(local i = 0; i < win.getNumChildren(); i++){
        local newWidget = win.getChildForIdx(i);
        iterateWidget(newWidget, 0);
    }

    _test.endTest();
}

function printWidget(widget, count){
    local out = "=";
    for(local i = 0; i < count; i++){
        out += "=";
    }
    print(out + widget.tostring());
}

function iterateWidget(widget, count){
    printWidget(widget, count);
    if(widget.getType() != _GUI_WIDGET_WINDOW) return;
    for(local i = 0; i < widget.getNumChildren(); i++){
        local newWidget = widget.getChildForIdx(i);
        print(i);
        iterateWidget(newWidget, count + 1);
    }
}