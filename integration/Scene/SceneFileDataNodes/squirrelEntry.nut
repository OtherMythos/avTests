//Query a parsed scene file through its node objects, without inserting it into the scene.

const EPSILON = 0.0001;

function assertClose(actual, expected, label){
    if(fabs(actual - expected) > EPSILON){
        print(label + " expected " + expected + " but was " + actual);
    }
    _test.assertTrue(fabs(actual - expected) <= EPSILON);
}

function assertVec3(vec, x, y, z, label){
    assertClose(vec.x, x, label + ".x");
    assertClose(vec.y, y, label + ".y");
    assertClose(vec.z, z, label + ".z");
}

function assertQuat(quat, w, x, y, z, label){
    assertClose(quat.w, w, label + ".w");
    assertClose(quat.x, x, label + ".x");
    assertClose(quat.y, y, label + ".y");
    assertClose(quat.z, z, label + ".z");
}

function start(){

    local data = _scene.parseSceneFile("res://res/sceneNodes.avscene");

    //Two top level elements in the file.
    _test.assertEqual(data.getNumRootNodes(), 2);

    local parent = data.getRootNode(0);
    _test.assertEqual(parent.getName(), "parent");
    _test.assertEqual(parent.getType(), _AV_SCENE_NODE_EMPTY);
    //An empty references no mesh and carries no user value.
    _test.assertEqual(parent.getMeshName(), null);
    _test.assertEqual(parent.getUserValue(), null);
    _test.assertEqual(parent.getAnimIdx(), null);
    _test.assertEqual(parent.getParent(), null);
    _test.assertEqual(parent.getNumChildren(), 2);

    //A root node's derived transform is just its own.
    assertVec3(parent.getPosition(), 10.0, 0.0, 0.0, "parent local pos");
    assertVec3(parent.getDerivedPosition(), 10.0, 0.0, 0.0, "parent derived pos");
    assertVec3(parent.getDerivedScale(), 2.0, 3.0, 4.0, "parent derived scale");

    local child = parent.getChild(0);
    _test.assertEqual(child.getName(), "child");
    _test.assertEqual(child.getType(), _AV_SCENE_NODE_MESH);
    _test.assertEqual(child.getMeshName(), "cube");
    _test.assertEqual(child.getUserValue(), null);
    _test.assertEqual(child.getAnimIdx(), 3);
    _test.assertEqual(child.getNumChildren(), 0);

    //The local transform is what the file said, untouched by the parent.
    assertVec3(child.getPosition(), 1.0, 2.0, 3.0, "child local pos");
    assertVec3(child.getScale(), 0.5, 0.5, 0.5, "child local scale");
    assertQuat(child.getOrientation(), 0.7071068, 0.7071068, 0.0, 0.0, "child local orientation");

    //The parent scales by (2,3,4) and turns a quarter about y, so (1,2,3) scales to (2,6,12),
    //rotates to (12,6,-2) and offsets by (10,0,0).
    assertVec3(child.getDerivedPosition(), 22.0, 6.0, -2.0, "child derived pos");
    assertVec3(child.getDerivedScale(), 1.0, 1.5, 2.0, "child derived scale");
    assertQuat(child.getDerivedOrientation(), 0.5, 0.5, 0.5, -0.5, "child derived orientation");

    //getParent walks back to the same node the child came from.
    _test.assertEqual(child.getParent().getName(), "parent");

    local marker = parent.getChild(1);
    _test.assertEqual(marker.getName(), "marker");
    _test.assertEqual(marker.getType(), _AV_SCENE_NODE_USER2);
    _test.assertEqual(marker.getUserValue(), "spawnPoint");
    _test.assertEqual(marker.getMeshName(), null);

    //The second root has no name in the file.
    local secondRoot = data.getRootNode(1);
    _test.assertEqual(secondRoot.getName(), null);
    _test.assertEqual(secondRoot.getMeshName(), "lineBox");
    assertVec3(secondRoot.getDerivedPosition(), -5.0, 0.0, 0.0, "second root derived pos");

    //Out of range lookups throw rather than reading past the end.
    foreach(c,i in [
        function(){ data.getRootNode(2); },
        function(){ data.getRootNode(-1); },
        function(){ parent.getChild(2); }
    ]){
        local failed = false;
        try{ i(); }catch(e){ print(e); failed = true; }
        _test.assertTrue(failed);
    }

    //A node holds the parsed scene alive, so dropping every reference to the scene itself must
    //not take the data out from under the nodes still pointing into it.
    data = null;
    collectgarbage();
    assertVec3(child.getDerivedPosition(), 22.0, 6.0, -2.0, "child derived pos after gc");
    _test.assertEqual(child.getParent().getName(), "parent");

    //The parsed scene still inserts as it always did.
    local parentNode = _scene.getRootSceneNode().createChildSceneNode();
    local secondData = _scene.parseSceneFile("res://res/sceneNodes.avscene");
    _scene.insertParsedSceneFile(secondData, parentNode);
    _test.assertEqual(parentNode.getNumChildren(), 2);

    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);

    _test.endTest();
}
