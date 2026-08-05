//_random in a worker vm is backed by that worker's own generator, not the process wide
//rand()/srand() the main vm's _random uses.

function run(input){
    if(input.seed >= 0) _random.seed(input.seed);

    local ints = [];
    for(local i = 0; i < 8; i++) ints.append(_random.randInt(0, 1000000));

    local floats = [];
    for(local i = 0; i < 4; i++) floats.append(_random.rand());

    local array = [10, 20, 30, 40, 50];
    local index = _random.randIndex(array);

    return { ints = ints, floats = floats, index = index };
}
