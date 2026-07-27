//Checks that plugin metadata reaches script, in declaration order, and that a plugin with
//neither an EntryFile nor a Bin section is still listed.

function start(){
    local plugins = _plugin.getPlugins();
    _test.assertEqual(2, plugins.len());

    _test.assertEqual("AlphaPlugin", plugins[0].name);
    _test.assertEqual("The first plugin.", plugins[0].description);
    _test.assertEqual("0.1.0", plugins[0].version);
    _test.assertTrue(plugins[0].directory.find("plugins/alpha") != null);

    //Beta declares no version, which should come through as an empty string rather than null.
    _test.assertEqual("BetaPlugin", plugins[1].name);
    _test.assertEqual("", plugins[1].version);

    //Alpha has an entry file so it ran; beta has nothing to run.
    _test.assertTrue(::alphaStarted);

    _test.endTest();
}

function update(){

}
