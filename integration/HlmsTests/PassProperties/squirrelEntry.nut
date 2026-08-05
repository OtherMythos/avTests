//A test for the per-pass shader property API on the Hlms dispatch listener.

function start(){
    //getPass returns a handle bound to a compositor-pass identifier.
    local pass = _hlms.pbs.getPass(20);
    _test.assertTrue(pass != null);

    //Registering / clearing properties should not error.
    pass.setProperty("renderSceneDecorations", 1);
    pass.setProperty("disableFog", 1);
    pass.setProperty("disableFog", 0);   //overwrite
    pass.clearProperty("renderSceneDecorations");

    //A second handle for the same identifier is equally valid.
    local passAgain = _hlms.pbs.getPass(20);
    _test.assertTrue(passAgain != null);
    passAgain.setProperty("someOtherProperty", 1);

    //A different identifier, and the unlit Hlms, are independent.
    local otherPass = _hlms.pbs.getPass(21);
    otherPass.setProperty("foo", 1);

    local unlitPass = _hlms.unlit.getPass(20);
    unlitPass.setProperty("bar", 1);

    _test.endTest();
}
