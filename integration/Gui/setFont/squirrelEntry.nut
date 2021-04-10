//Check that fonts can be set for the appropriate widgets.
//Just set them up, and if the engine crashes then fail.

//I set it to the default engine font because when dejaVuSerif gets set it becomes the default.
//Setting the engine default shows this can be overriden.

function start(){
    local layout = _gui.createLayoutLine();

    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);
    win.setHidden(false);

    local button = win.createButton();
    button.setDefaultFont(1);
    button.setText("A button");
    layout.addCell(button);

    local label = win.createLabel();
    label.setDefaultFont(1);
    label.setText("some text");
    layout.addCell(label);

    local editbox = win.createEditbox();
    editbox.setDefaultFont(1);
    editbox.setSize(300, 100);
    editbox.setText("This is some text");
    layout.addCell(editbox);

    local checkbox = win.createCheckbox();
    checkbox.setDefaultFont(1);
    checkbox.setText("This is a checkbox");
    layout.addCell(checkbox);

    layout.layout();
}
