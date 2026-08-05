//Enough work per run that several workers are genuinely in flight at once against a job pool
//which is smaller than the number of workers.

function setup(){
    mIdentity <- -1;
}

function run(input){
    //The first run tells this worker who it is. If two workers ever shared a vm this would show
    //up immediately as the wrong identity coming back.
    if(mIdentity < 0) mIdentity = input.id;

    local acc = 0;
    for(local i = 0; i < 200000; i++) acc += (i % 7);

    return { id = mIdentity, echoed = input.id, checksum = acc };
}
