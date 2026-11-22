//Per-datablock custom pieces and custom properties: setting, reading back, clearing
//and cloning them, and refusing bad input.

function assertThrows(func){
    local thrown = false;
    try{
        func();
    }catch(e){
        thrown = true;
    }
    _test.assertTrue(thrown);
}

function checkPieceFiles(datablock){
    _test.assertEqual(null, datablock.getCustomPieceFile(_HLMS_PIECE_STAGE_PS));

    datablock.setCustomPieceFile("customPiecesSolidGreen.any", _HLMS_PIECE_STAGE_PS);
    _test.assertEqual("customPiecesSolidGreen.any", datablock.getCustomPieceFile(_HLMS_PIECE_STAGE_PS));
    //Stages are independent.
    _test.assertEqual(null, datablock.getCustomPieceFile(_HLMS_PIECE_STAGE_VS));
    _test.assertEqual(null, datablock.getCustomPieceFile(_HLMS_PIECE_STAGE_PRE));

    //Setting the same file again is allowed.
    datablock.setCustomPieceFile("customPiecesSolidGreen.any", _HLMS_PIECE_STAGE_PS);

    //An empty name clears it.
    datablock.setCustomPieceFile("", _HLMS_PIECE_STAGE_PS);
    _test.assertEqual(null, datablock.getCustomPieceFile(_HLMS_PIECE_STAGE_PS));

    //An explicit resource group.
    datablock.setCustomPieceFile("customPiecesSolidGreen.any", _HLMS_PIECE_STAGE_PS, "General");
    _test.assertEqual("customPiecesSolidGreen.any", datablock.getCustomPieceFile(_HLMS_PIECE_STAGE_PS));
    datablock.setCustomPieceFile("", _HLMS_PIECE_STAGE_PS);

    assertThrows(function(){ datablock.setCustomPieceFile("customPiecesDoesNotExist.any", _HLMS_PIECE_STAGE_PS); });
    assertThrows(function(){ datablock.setCustomPieceFile("customPiecesSolidGreen.any", 100); });
    assertThrows(function(){ datablock.setCustomPieceFile("customPiecesSolidGreen.any", -1); });
    assertThrows(function(){ datablock.getCustomPieceFile(100); });
}

function checkPieceCode(datablock){
    local code = "@piece( custom_vs_preExecution )\n@end\n";
    datablock.setCustomPieceCode("customPiecesTestMemory", code, _HLMS_PIECE_STAGE_VS);
    _test.assertEqual("customPiecesTestMemory", datablock.getCustomPieceFile(_HLMS_PIECE_STAGE_VS));

    //The same name must always mean the same code, as it's how Hlms identifies the piece.
    datablock.setCustomPieceCode("customPiecesTestMemory", code, _HLMS_PIECE_STAGE_VS);
    assertThrows(function(){
        datablock.setCustomPieceCode("customPiecesTestMemory", "@piece( custom_vs_posExecution )\n@end\n", _HLMS_PIECE_STAGE_VS);
    });
    assertThrows(function(){ datablock.setCustomPieceCode("", code, _HLMS_PIECE_STAGE_VS); });

    datablock.setCustomPieceCode("", "", _HLMS_PIECE_STAGE_VS);
    _test.assertEqual(null, datablock.getCustomPieceFile(_HLMS_PIECE_STAGE_VS));
}

function checkCustomProperties(datablock){
    _test.assertEqual(0, datablock.getCustomProperties().len());

    datablock.setCustomProperties({ customPiecesMode = 3, customPiecesFlag = true, customPiecesOff = false });
    local properties = datablock.getCustomProperties();
    _test.assertEqual(3, properties.len());
    _test.assertEqual(3, properties["customPiecesMode"]);
    _test.assertEqual(1, properties["customPiecesFlag"]);
    _test.assertEqual(0, properties["customPiecesOff"]);

    //A new set replaces the old one rather than merging into it.
    datablock.setCustomProperties({ customPiecesMode = -2 });
    properties = datablock.getCustomProperties();
    _test.assertEqual(1, properties.len());
    _test.assertEqual(-2, properties["customPiecesMode"]);

    assertThrows(function(){ datablock.setCustomProperties({ customPiecesMode = 1.5 }); });
    assertThrows(function(){ datablock.setCustomProperties({ customPiecesMode = "one" }); });
    //A failed set leaves the previous properties alone.
    _test.assertEqual(-2, datablock.getCustomProperties()["customPiecesMode"]);

    datablock.setCustomProperties({});
    _test.assertEqual(0, datablock.getCustomProperties().len());
}

function checkClone(datablock){
    datablock.setCustomPieceFile("customPiecesSolidGreen.any", _HLMS_PIECE_STAGE_PS);
    datablock.setCustomProperties({ customPiecesMode = 5 });

    local cloned = datablock.cloneBlock(datablock.getName() + "Clone");
    _test.assertEqual("customPiecesSolidGreen.any", cloned.getCustomPieceFile(_HLMS_PIECE_STAGE_PS));
    _test.assertEqual(5, cloned.getCustomProperties()["customPiecesMode"]);
}

function start(){
    _test.assertEqual(0, _HLMS_PIECE_STAGE_PRE);
    _test.assertEqual(1, _HLMS_PIECE_STAGE_VS);
    _test.assertEqual(2, _HLMS_PIECE_STAGE_PS);
    _test.assertEqual(3, _HLMS_PIECE_STAGE_GS);
    _test.assertEqual(4, _HLMS_PIECE_STAGE_HS);
    _test.assertEqual(5, _HLMS_PIECE_STAGE_DS);

    foreach(datablock in [
        _hlms.pbs.createDatablock("customPiecesPbs"),
        _hlms.unlit.createDatablock("customPiecesUnlit")
    ]){
        checkPieceFiles(datablock);
        checkPieceCode(datablock);
        checkCustomProperties(datablock);
        checkClone(datablock);
    }

    _test.endTest();
}
