//Check that both quaternion and degree rotations can be applied to a scene node.

function start(){

    ::stage <- 0;
    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);
    ::rootNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::previousPos <- Vec3(-10, -10, 0);
    rootNode.attachObject(_scene.createItem("cube"));

    _animation.loadAnimationFile("res://AnimationScript.xml");

    ::animationInfo <- _animation.createAnimationInfo([rootNode]);
    _test.assertEqual(_animation.getNumActiveAnimations(), 0);
    ::currentAnim <- _animation.createAnimation("animQuatRotate", animationInfo);
}

function update(){
    if(stage == 0){
        if(_animation.getNumActiveAnimations() == 0){
            ::currentAnim <- _animation.createAnimation("animDegreeRotate", animationInfo);
            stage++;
        }
    }
    else if(stage == 1){
        if(_animation.getNumActiveAnimations() == 0){
            _test.endTest();
        }
    }
}
