//Checks that deleting datablocks works as intended.

function start(){
    //Make them share the same name just to see that what was previously pbs can be unlit.
    {
        local datablock = _hlms.pbs.createDatablock("someDatablockName");
        local queryDatablock = _hlms.getDatablock("someDatablockName");
        _test.assertNotEqual(null, queryDatablock);
        _test.assertEqual(datablock.getName(), queryDatablock.getName());

        _hlms.destroyDatablock("someDatablockName");
        queryDatablock = _hlms.getDatablock("someDatablockName");
        _test.assertEqual(null, queryDatablock);
    }

    {
        local datablock = _hlms.unlit.createDatablock("someDatablockName");
        local queryDatablock = _hlms.getDatablock("someDatablockName");
        _test.assertEqual(datablock.getName(), queryDatablock.getName());
        _test.assertNotEqual(null, queryDatablock);

        _hlms.destroyDatablock("someDatablockName");
        queryDatablock = _hlms.getDatablock("someDatablockName");
        _test.assertEqual(null, queryDatablock);
    }

    _test.endTest();
}
