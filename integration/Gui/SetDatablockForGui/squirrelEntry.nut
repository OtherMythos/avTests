//A test to check datablocks can be correctly applied to panels, and the necessary checks are made as they are set.

function start(){

    local win = _gui.createWindow();
    win.setPosition(600, 200);
    win.setSize(500, 500);

    local panel = win.createPanel();

    //Will return an error if given an invalid datablock.
    {

        local failed = false;
        try{
            panel.setDatablock("invalidDatablock");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    local datablock = _hlms.pbs.createDatablock("someDatablockName");
    //Shouldn't be able to set a pbs datablock to gui objects.
    {

        local failed = false;
        try{
            panel.setDatablock(datablock);
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }
    {

        local failed = false;
        try{
            panel.setDatablock("someDatablockName");
        }catch(e){
            failed = true;
        }
        _test.assertTrue(failed);
    }

    local unlitBlock = _hlms.unlit.createDatablock("someUnlitBlock");
    //Should all work fine with unlit blocks.
    {
        panel.setDatablock("someUnlitBlock");
        panel.setDatablock(unlitBlock);
    }

    _test.endTest();
}
