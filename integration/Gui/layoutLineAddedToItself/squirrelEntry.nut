//Tests a bug I found when adding a layout as a cell to itself.

function start(){
    local layout = _gui.createLayoutLine();

    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);
    win.setHidden(false);

    //An error should be thrown here, and the engine should not crash.
    local failed = false;
    try{
        layout.addCell(layout);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    layout.layout();

    _test.endTest();
}
