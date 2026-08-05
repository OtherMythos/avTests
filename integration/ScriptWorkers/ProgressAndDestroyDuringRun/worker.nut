//Deliberately slow, so the main thread gets several frames in which to observe the run in
//progress and then interrupt it.

function run(input){
    local steps = input.steps;
    for(local i = 0; i < steps; i++){
        if(_workerSelf.isCancelled()) return { cancelled = true, reached = i };

        local acc = 0.0;
        for(local j = 0; j < 40000; j++) acc += sqrt((j + 1).tofloat());

        _workerSelf.setProgress((i + 1).tofloat() / steps.tofloat());
    }

    return { cancelled = false, reached = steps };
}
