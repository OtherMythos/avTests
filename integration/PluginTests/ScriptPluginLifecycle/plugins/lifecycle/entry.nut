//The engine loads this as a callback script, so these functions are picked up automatically.

//Relative to this file, not to the project running the plugin.
_doFile("script://sub/helper.nut");

::pluginTrail <- [];
::pluginUpdateCount <- 0;
::pluginDeltas <- [];

function start(){
    ::pluginTrail.append("pluginStart");
    //Proves the include above actually ran and landed somewhere reachable.
    ::pluginTrail.append(::pluginHelperValue);
}

function update(dt){
    ::pluginUpdateCount++;
    ::pluginDeltas.append(dt);
}

function sceneSafeUpdate(){
    if(::pluginTrail.len() > 0 && ::pluginTrail.top() == "sceneSafe") return;
    ::pluginTrail.append("sceneSafe");
}

function end(){
    //Nothing can assert after the test ends, so this just has to not crash.
    print("LifecyclePlugin end");
}
