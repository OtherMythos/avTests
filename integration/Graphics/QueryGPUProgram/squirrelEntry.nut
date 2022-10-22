//A test to check gpu programs can be queried.

function start(){
    //Actual test
    local failed = false;
    try{
        _graphics.getGpuProgramByName("someProgramWhichDoesNotExist");
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);

    local fragProg = _graphics.getGpuProgramByName("glitchEffect_ps");
    _test.assertEqual(fragProg.getType(), _GPU_PROG_TYPE_FRAGMENT);

    local vertProg = _graphics.getGpuProgramByName("Ogre/Compositor/Quad_vs");
    _test.assertEqual(vertProg.getType(), _GPU_PROG_TYPE_VERTEX);

    _test.endTest();
}

function update(){

}