//Reports what is and is not in this vm's root table, so the main thread can assert on it.
//The point of running this inside a real engine rather than only in a unit test is that the main
//vm here has every namespace registered - if a worker vm ever shared a root table, or a delegate
//table leaked across, this is where it would show.

function has(name){
    return name in getroottable();
}

function run(input){
    local present = {};
    foreach(name in input.names){
        present[name] <- has(name);
    }

    local systemMembers = {};
    foreach(name in input.systemNames){
        systemMembers[name] <- (name in _system);
    }

    local randomMembers = {};
    foreach(name in input.randomNames){
        randomMembers[name] <- (name in _random);
    }

    return {
        root = present,
        system = systemMembers,
        random = randomMembers,
        //Proves the standard libraries are genuinely usable, not merely present.
        mathWorks = sqrt(9.0),
        stringWorks = format("%d-%s", 7, "ok"),
        executionFlag = EXECUTION_WORKER_VM,
        //_workerSelf must work from here, being the only route back to the main thread.
        cancelled = _workerSelf.isCancelled()
    };
}
