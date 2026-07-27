//Checks the lifecycle of a script plugin: that it is started before the project, that update
//runs each fixed step with a delta, that sceneSafeUpdate runs, and that plugin relative
//script:// includes resolve against the plugin rather than the project.

::finished <- false;

function start(){
    //The plugin must already have been started by the time the project starts, and the
    //script:// include in its entry file must have run before that.
    _test.assertEqual("pluginStart", ::pluginTrail[0]);
    _test.assertEqual("helperLoaded", ::pluginTrail[1]);
}

function update(){
    if(::finished) return;
    //Give the engine a few frames to accumulate plugin updates.
    if(::pluginUpdateCount < 5) return;

    //The plugin's update declared a delta parameter, so it should be receiving one each time.
    _test.assertEqual(::pluginUpdateCount, ::pluginDeltas.len());
    _test.assertTrue(::pluginDeltas[0] > 0.0);

    //sceneSafeUpdate runs once per rendered frame.
    _test.assertTrue(::pluginTrail.find("sceneSafe") != null);

    _test.assertTrue(_plugin.isLoaded("LifecyclePlugin"));
    _test.assertFalse(_plugin.isLoaded("NotAPlugin"));

    ::finished = true;
    _test.endTest();
}
