//A test to check that mesh functions can be called correctly.

function start(){
    local mesh = _mesh.create("cube");

    //Check for both Vec3 and Vector3.
    local startPos = Vec3(1,2,3);
    mesh.setPosition(startPos);
    _test.assertEqual(startPos, mesh.getPosition());
    _test.assertEqual(Vec3(1, 2, 3), mesh.getPositionVec3());

    mesh.setScale(Vec3(1, 2, 3));
    _test.assertEqual(Vec3(1, 2, 3), mesh.getScale());
    mesh.setScale(6, 7, 8);
    _test.assertEqual(Vec3(6, 7, 8), mesh.getScale());

    _test.endTest();
}
