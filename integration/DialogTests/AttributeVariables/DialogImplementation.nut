function dialogString(dialog, actorId){
    ::currentString <- dialog;
}

function actorChangeDirection(a, d){
    ::currentActorDirection <- [a, d];
}

function actorMoveTo(a, x, y, z){
    ::currentActorMoveTo <- [a, x, y, z];
}
