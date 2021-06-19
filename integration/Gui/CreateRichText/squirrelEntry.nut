//A test that sets rich text values of labels, checking the api.

function start(){
    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);
    win.setHidden(false);

    local firstLabel = win.createLabel();
    firstLabel.setText("test text");

    //Valid so shouldn't throw an error.
    firstLabel.setRichText([
        {"fontSize":10.0, "offset": 0, "len": 4},
        {"fontSize":20.0, "offset": 5, "len": 4, "col": "1 0 0 1"},
    ]);

    local failed = false;
    try{
        firstLabel.setRichText([
            {"someInvalidKey":10.0, "offset": 0, "len": 4}
        ]);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    failed = false;
    try{
        firstLabel.setRichText([
            {"someInvalidValue":Vec3(10, 20, 30), "offset": 0, "len": 4}
        ]);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    failed = false;
    try{
        //Incorrect parameters
        firstLabel.setRichText([
            {"fontSize":10.0, "offset": 0, "len": 4}
        ], 20, 20);
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    firstLabel.setRichText([
        {"fontSize":10.0, "offset": 0, "len": 4},
        {"fontSize":20.0, "offset": 5, "len": 4, "col": "1 0 0 1"},
    ], _GUI_WIDGET_STATE_IDLE);


    //Test will timeout when done.
}
