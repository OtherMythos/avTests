//Creates many animations at once, checks they can play out and then eventually be destroyed when they timeout.

class AnimObject{
    mAnim = null;
    mNode = null;
    constructor(anim, node){
        mAnim = anim;
        mNode = node;
    }

    function destroy(){
        //The animation should be destroyed when the instance is destroyed.
        mNode.destroyNodeAndChildren();
    }
}

const POS_OFFSET = 10;

function start(){
    _camera.lookAt(0, 0, 0);
    _camera.setPosition(POS_OFFSET/2, POS_OFFSET/2, 50);

    _animation.loadAnimationFile("res://Animations.xml");

    ::parentNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::totalAnimations <- ["animPos", "animScale", "animOrientate"];
    ::currentAnims <- [];

    ::insertTimer <- 0;
}

function clearAll(){
    foreach(i in ::currentAnims){
        i.destroy();
    }
    ::currentAnims.clear();
}

function createAnimableObject(){
    //Create two children so the relative transforms stick.
    local parent = parentNode.createChildSceneNode();
    local target = parent.createChildSceneNode();
    target.attachObject(_scene.createItem("cube"));

    local animationInfo = _animation.createAnimationInfo([target]);
    local targetAnim = ::totalAnimations[_random.randInt(totalAnimations.len() - 1)];
    local currentAnim = _animation.createAnimation(targetAnim, animationInfo);

    ::currentAnims.append(AnimObject(currentAnim, target));
    parent.setPosition(_random.randVec3() * POS_OFFSET);
}

function update(){
    ::insertTimer++;
    if(insertTimer % 5 == 0){
        createAnimableObject();
    }

    //Destroy one of them.
    if(insertTimer % 10 == 0){
        local target = _random.randInt(currentAnims.len() - 1);
        ::currentAnims[target].destroy();
        ::currentAnims.remove(target);
    }

    //Every now and then destroy them all.
    if(insertTimer % 500 == 0){
        clearAll();
    }
}
