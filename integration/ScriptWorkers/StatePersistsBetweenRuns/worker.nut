//The worker vm is kept alive between runs, so anything setup() or a previous run() left in this
//table is still here. That is the whole reason a worker is persistent rather than fire and forget.

function setup(){
    mTotal <- 0;
    mRuns <- 0;
    mHistory <- [];
}

function run(input){
    mRuns++;
    mTotal += input.amount;
    mHistory.append(input.amount);

    return { total = mTotal, runs = mRuns, history = mHistory };
}
