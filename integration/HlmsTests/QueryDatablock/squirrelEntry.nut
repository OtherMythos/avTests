//A test to check that the engine is able to query datablocks.

function start(){
    {
        local datablock = _hlms.pbs.createDatablock("someDatablockNamePbs");
        local queryDatablock = _hlms.getDatablock("someDatablockNamePbs");
        _test.assertTrue(datablock.equals(queryDatablock));
    }

    {
        local datablock = _hlms.pbs.createDatablock("someDatablockNameUnlit");
        local queryDatablock = _hlms.getDatablock("someDatablockNameUnlit");
        _test.assertTrue(datablock.equals(queryDatablock));
    }

    {
        local queryDatablock = _hlms.getDatablock("someDatablockThatDoesntExist");
        _test.assertEqual(null, queryDatablock);
    }

    _test.endTest();
}
