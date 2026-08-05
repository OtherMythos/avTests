//Fails on the first run and succeeds afterwards, so a failure can be shown not to poison the vm.

function setup(){
    mCalls <- 0;
}

function run(input){
    mCalls++;
    if(mCalls == 1) throw "deliberate failure inside the worker";

    return { calls = mCalls };
}
