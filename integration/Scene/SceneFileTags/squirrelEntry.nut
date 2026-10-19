//Look nodes up in a parsed scene by tag, without inserting the scene.

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

function start(){

    local data = _scene.parseSceneFile("res://res/sceneTags.avscene");

    //A tag reaches straight to its node, wherever it sits in the hierarchy.
    local crate = data.getNodeByTag("crate");
    _test.assertNotEqual(crate, null);
    _test.assertEqual(crate.getTag(), "crate");
    _test.assertEqual(crate.getName(), "child");
    _test.assertEqual(crate.getMeshName(), "cube");

    //The parent scales by (2,3,4) and turns a quarter about y, so (1,2,3) scales to (2,6,12),
    //rotates to (12,6,-2) and offsets by (10,0,0).
    assertVec3(crate.getDerivedPosition(), 22.0, 6.0, -2.0, "crate derived pos");

    //Tags work on empties and user nodes too, not just meshes.
    local root = data.getNodeByTag("root");
    _test.assertEqual(root.getName(), "parent");
    _test.assertEqual(root.getType(), _AV_SCENE_NODE_EMPTY);
    _test.assertEqual(root.getParent(), null);

    local spawn = data.getNodeByTag("spawn");
    _test.assertEqual(spawn.getType(), _AV_SCENE_NODE_USER2);
    _test.assertEqual(spawn.getUserValue(), "spawnPoint");
    //(0,1,0) scaled by (2,3,4) is (0,3,0), unmoved by a turn about y, offset by (10,0,0).
    assertVec3(spawn.getDerivedPosition(), 10.0, 3.0, 0.0, "spawn derived pos");

    //A tagged node reached by navigation rather than lookup reports the same tag.
    _test.assertEqual(root.getChild(0).getTag(), "crate");
    //An untagged node reports no tag rather than an empty string or a neighbour's.
    _test.assertEqual(root.getChild(2).getName(), "untagged");
    _test.assertEqual(root.getChild(2).getTag(), null);

    //A tag nothing carries is a miss, not an error.
    _test.assertEqual(data.getNodeByTag("notATag"), null);
    _test.assertTrue(data.hasTag("crate"));
    _test.assertFalse(data.hasTag("notATag"));
    //Names are not tags.
    _test.assertFalse(data.hasTag("child"));

    //A node found by tag holds the parsed scene alive.
    data = null;
    collectgarbage();
    assertVec3(crate.getDerivedPosition(), 22.0, 6.0, -2.0, "crate derived pos after gc");
    _test.assertEqual(crate.getTag(), "crate");

    _camera.setPosition(0, 0, 50);
    _camera.lookAt(0, 0, 0);

    _test.endTest();
}
