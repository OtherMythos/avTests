//A broken plugin should be reported and skipped, never take the engine down with it, and never
//stop the plugins declared after it from loading.

function start(){
    local plugins = _plugin.getPlugins();

    //Only the last entry is well formed. The five before it are each broken in a different way.
    _test.assertEqual(1, plugins.len());
    _test.assertEqual("GoodPlugin", plugins[0].name);

    _test.assertTrue(_plugin.isLoaded("GoodPlugin"));
    _test.assertFalse(_plugin.isLoaded("Malformed"));
    _test.assertFalse(_plugin.isLoaded("MissingEntry"));

    _test.assertTrue(::goodStarted);

    _test.endTest();
}

function update(){

}
