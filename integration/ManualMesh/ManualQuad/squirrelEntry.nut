//A test to check that simple meshes can be created from script code.

function start(){

    local meshName = "testManualCube";
    local testMesh = _graphics.createManualMesh(meshName);
    _test.assertTrue(testMesh.tostring().find(meshName) != null);
    _test.assertEqual(testMesh.getName(), meshName);
    local subMesh = testMesh.createSubMesh();

    local vertexElemVec = _graphics.createVertexElemVec();
    vertexElemVec.pushVertexElement(_VET_FLOAT3, _VES_POSITION);
    vertexElemVec.pushVertexElement(_VET_FLOAT2, _VES_TEXTURE_COORDINATES);

    _test.assertEqual(subMesh, testMesh.getSubMesh(0));

    local b = blob(4*5*4);
    local x1 = 0.0;
    local y1 = 0.0;
    local x2 = 1.0;
    local y2 = -1.0;
    b.writen(x2, 'f');b.writen(y2, 'f');b.writen(0.0, 'f');b.writen(1.0, 'f');b.writen(1.0, 'f');
    b.writen(x2, 'f');b.writen(y1, 'f');b.writen(0.0, 'f');b.writen(1.0, 'f');b.writen(0.0, 'f');
    b.writen(x1, 'f');b.writen(y1, 'f');b.writen(0.0, 'f');b.writen(0.0, 'f');b.writen(0.0, 'f');
    b.writen(x1, 'f');b.writen(y2, 'f');b.writen(0.0, 'f');b.writen(0.0, 'f');b.writen(1.0, 'f');

    local buffer = _graphics.createVertexBuffer(vertexElemVec, 4, 4, b);

    //TODO add the index buffer creation.
    //Separate out the vertex elements array.

    local bb = blob(6*4*2);
    bb.writen(0, 'w');
    bb.writen(1, 'w');
    bb.writen(2, 'w');
    bb.writen(2, 'w');
    bb.writen(3, 'w');
    bb.writen(0, 'w');
    local indexBuffer = _graphics.createIndexBuffer(_IT_16BIT, bb, 6);

    local vao = _graphics.createVertexArrayObject(buffer, indexBuffer, _OT_TRIANGLE_LIST);

    subMesh.pushMeshVAO(vao, _VP_NORMAL);

    local bounds = AABB(Vec3(), Vec3());
    testMesh.setBounds(bounds);
    testMesh.setBoundingSphereRadius(1.732);

    local item = _scene.createItem(testMesh);
    item.setDatablock("textureUnlit");
    local newNode = _scene.getRootSceneNode().createChildSceneNode();
    newNode.attachObject(item);

    _camera.setPosition(0, 0, 30);
    _camera.lookAt(0, 0, 0);

    //TODO compare the two meshes.
    //Tests:
    //Check both 32 and 16 bit indice types work.
    //Check the indice values work by defining the verts of a quad and drawing the two triangles separately with the same vbo.

    //_test.endTest();
}
