//A test to check that unlit datablocks can be created correctly.

function start(){
    local datablock = _hlms.unlit.createDatablock("someUnlitDatablock");
    {
        local queryDatablock = _hlms.getDatablock("someUnlitDatablock");
        _test.assertTrue(datablock.equals(queryDatablock));
    }

    datablock.setUseColour(true);
    local intendedColour = ColourValue(1, 0, 1, 1);
    datablock.setColour(intendedColour);

    _test.assertEqual(intendedColour, datablock.getColour());

    _test.endTest();
}
