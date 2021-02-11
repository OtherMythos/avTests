//Check that pbs datablocks can be animated. This test times out after 6 seconds.

function start(){

    ::stage <- 0;
    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);
    ::rootNode <- _scene.getRootSceneNode().createChildSceneNode();
    ::previousPos <- Vec3(-10, -10, 0);
    local cubeItem = _scene.createItem("cube");
    rootNode.attachObject(cubeItem);

    local datablock = _hlms.pbs.createDatablock("someDatablockName");
    cubeItem.setDatablock(datablock);

    _animation.loadAnimationFile("res://AnimationScript.xml");

    ::animationInfo <- _animation.createAnimationInfo([datablock]);
    ::currentAnim <- _animation.createAnimation("animDatablock", animationInfo);
}

function update(){
    _test.assertEqual(_animation.getNumActiveAnimations(), 1);
}
