//The value of a worker vm is in what is missing from it. Anything reaching the scene graph, the
//entity system, the gui or Ogre would let a worker thread corrupt the engine while the main thread
//is using it, so this asserts the reduced root table from inside a fully started engine.

::forbidden <- [
    "_scene", "_entity", "_component", "_gui", "_physics", "_camera", "_mesh",
    "_animation", "_input", "_window", "_audio", "_state",
    "_compositor", "_graphics", "_hlms", "_resources", "_dataStore", "_registry",
    "_event", "_scriptingState", "_settings", "_plugin",
    //A worker cannot create workers.
    "_worker",
    //Reaches the window.
    "_shutdownEngine",
    //Userdata constructors. Every delegate table in the engine is bound to the main vm.
    "Vec3", "Vec2", "Quat", "Timer"
];

::required <- [
    "_workerSelf", "_random", "_system",
    "_doFile", "_doFileWithContext", "_compileBuffer", "_time", "_prettyPrint"
];

function start(){
    //Sanity check on the other side of the boundary: the main vm really does have these, so an
    //absence in the worker means the worker vm is reduced, not that the name is simply unused.
    _test.assertTrue("_scene" in getroottable());
    _test.assertTrue("_gui" in getroottable());
    _test.assertTrue("Vec3" in getroottable());
    _test.assertTrue("_shutdownEngine" in getroottable());

    ::w <- _worker.create("res://worker.nut");

    local names = [];
    foreach(n in ::forbidden) names.append(n);
    foreach(n in ::required) names.append(n);

    _test.assertTrue(::w.dispatch({
        names = names,
        systemNames = ["readJSONAsTable", "writeJsonAsFile", "mkdir", "remove", "removeAll", "rename"],
        randomNames = ["rand", "randInt", "randIndex", "seed", "randVec3", "randVec2", "genPerlinNoise"]
    }));

    ::finished <- false;
}

function update(){
    if(::finished) return;
    if(::w.poll() != _WORKER_READY) return;
    ::finished = true;

    local result = ::w.claim();

    foreach(name in ::forbidden){
        _test.assertFalse(result.root[name]);
    }
    foreach(name in ::required){
        _test.assertTrue(result.root[name]);
    }

    //_system carries json and nothing which mutates the filesystem.
    _test.assertTrue(result.system["readJSONAsTable"]);
    _test.assertTrue(result.system["writeJsonAsFile"]);
    _test.assertFalse(result.system["mkdir"]);
    _test.assertFalse(result.system["remove"]);
    _test.assertFalse(result.system["removeAll"]);
    _test.assertFalse(result.system["rename"]);

    //_random keeps the value returning functions and drops the ones needing userdata or a
    //process wide seed.
    _test.assertTrue(result.random["rand"]);
    _test.assertTrue(result.random["randInt"]);
    _test.assertTrue(result.random["randIndex"]);
    _test.assertTrue(result.random["seed"]);
    _test.assertFalse(result.random["randVec3"]);
    _test.assertFalse(result.random["randVec2"]);
    _test.assertFalse(result.random["genPerlinNoise"]);

    _test.assertEqual(result.mathWorks, 3.0);
    _test.assertEqual(result.stringWorks, "7-ok");
    _test.assertEqual(result.executionFlag, 1);
    _test.assertFalse(result.cancelled);

    //And the main vm says it is not a worker.
    _test.assertEqual(EXECUTION_WORKER_VM, 0);

    ::w.destroy();
    _test.endTest();
}
