//A test that sets rich text values of labels, checking the api.

function start(){
    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);
    win.setHidden(false);

    local text = "テスト 猫犬肉";
    local firstLabel = win.createLabel();
    firstLabel.setText(text);

    //This function in relation to unicode caused some problems before.
    local value = strip(text);
}
