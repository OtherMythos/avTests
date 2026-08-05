//Runs in the worker vm.

function run(input){
    local out = [];
    for(local i = 0; i < input.count; i++){
        out.append(i * input.multiplier);
    }

    return {
        values = out,
        label = "from the worker",
        nested = { depth = { value = input.count } },
        executionFlag = EXECUTION_WORKER_VM
    };
}
