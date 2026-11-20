function assertOpenError(path, message){
    local thrown = null;
    try{
        _video.open(path);
    }catch(error){
        thrown = error;
    }

    _test.assertTrue(thrown != null);
    _test.assertEqual(thrown.find(message), 0);
}

function start(){
    assertOpenError("res://missing.mpg", "Cannot open MPEG-1 video");
    assertOpenError("res://avSetup.cfg", "No decodable MPEG-1 video");
    _test.endTest();
}
