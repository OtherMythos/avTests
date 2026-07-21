//A test to check that vertex buffers can be re-uploaded to from script code.
//
//This is the path CPU driven particle systems need. Ogre's map() is limited to
//once per frame and asserts if called again, which doesn't survive the engine's
//fixed timestep loop (script update runs 0-4 times per rendered frame), so the
//binding uses BufferPacked::upload() instead. The important thing this test
//proves is that upload() can be called repeatedly, both within a single frame
//and every frame thereafter.

const NUM_VERTS = 4;
const BYTES_PER_VERT = 20;   //float3 position + float2 uv

::vertexBuffer <- null;
::indexBuffer <- null;
::shadowedBuffer <- null;
::framesRun <- 0;

//Build the vertex data for a quad whose left edge sits at `offset`.
function buildQuadBlob(offset){
    local b = blob(NUM_VERTS * BYTES_PER_VERT);
    local x1 = offset;
    local x2 = offset + 1.0;
    local y1 = 0.0;
    local y2 = -1.0;
    b.writen(x2, 'f');b.writen(y2, 'f');b.writen(0.0, 'f');b.writen(1.0, 'f');b.writen(1.0, 'f');
    b.writen(x2, 'f');b.writen(y1, 'f');b.writen(0.0, 'f');b.writen(1.0, 'f');b.writen(0.0, 'f');
    b.writen(x1, 'f');b.writen(y1, 'f');b.writen(0.0, 'f');b.writen(0.0, 'f');b.writen(0.0, 'f');
    b.writen(x1, 'f');b.writen(y2, 'f');b.writen(0.0, 'f');b.writen(0.0, 'f');b.writen(1.0, 'f');
    return b;
}

//Assert that calling `f` throws.
function assertThrows(f){
    local failed = false;
    try{
        f();
    }catch(e){
        failed = true;
    }
    _test.assertTrue(failed);
}

function start(){
    local testMesh = _graphics.createManualMesh("dynamicUploadQuad");
    local subMesh = testMesh.createSubMesh();

    local vertexElemVec = _graphics.createVertexElemVec();
    vertexElemVec.pushVertexElement(_VET_FLOAT3, _VES_POSITION);
    vertexElemVec.pushVertexElement(_VET_FLOAT2, _VES_TEXTURE_COORDINATES);

    //The third argument is a vestigial stride which Ogre ignores (it derives the
    //real stride from the vertex elements). Deliberately pass a value that is
    //NOT the vertex count, so that getNumElements() below fails if the binding
    //ever goes back to passing this where the vertex count belongs.
    //keepAsShadow is false: this buffer is re-uploaded every frame, so a CPU
    //shadow copy would just be a wasted second memcpy per upload.
    ::vertexBuffer = _graphics.createVertexBuffer(vertexElemVec, NUM_VERTS, 999, buildQuadBlob(0.0), false);

    _test.assertEqual(::vertexBuffer.getNumElements(), NUM_VERTS);
    _test.assertEqual(::vertexBuffer.getBytesPerElement(), BYTES_PER_VERT);

    local bb = blob(6 * 2);
    bb.writen(0, 'w'); bb.writen(1, 'w'); bb.writen(2, 'w');
    bb.writen(2, 'w'); bb.writen(3, 'w'); bb.writen(0, 'w');
    ::indexBuffer = _graphics.createIndexBuffer(_IT_16BIT, bb, 6);

    _test.assertEqual(::indexBuffer.getNumElements(), 6);
    _test.assertEqual(::indexBuffer.getBytesPerElement(), 2);

    local vao = _graphics.createVertexArrayObject(::vertexBuffer, ::indexBuffer, _OT_TRIANGLE_LIST);
    subMesh.pushMeshVAO(vao, _VP_NORMAL);

    testMesh.setBounds(AABB(Vec3(), Vec3(10, 10, 10)));
    testMesh.setBoundingSphereRadius(17.32);

    local item = _scene.createItem(testMesh);
    item.setDatablock("textureUnlit");
    _scene.getRootSceneNode().createChildSceneNode().attachObject(item);

    //--- Error cases ---

    //Index buffers are created BT_IMMUTABLE, so they can never be uploaded to.
    assertThrows(function(){ ::indexBuffer.upload(buildQuadBlob(0.0)); });

    //Blob larger than the buffer.
    assertThrows(function(){ ::vertexBuffer.upload(blob((NUM_VERTS + 1) * BYTES_PER_VERT)); });

    //Starting element leaves less room than the blob needs.
    assertThrows(function(){ ::vertexBuffer.upload(buildQuadBlob(0.0), 1); });

    //Starting element sits at, and past, the end of the buffer.
    assertThrows(function(){ ::vertexBuffer.upload(blob(BYTES_PER_VERT), NUM_VERTS); });
    assertThrows(function(){ ::vertexBuffer.upload(blob(BYTES_PER_VERT), 100); });

    //Negative starting element.
    assertThrows(function(){ ::vertexBuffer.upload(blob(BYTES_PER_VERT), -1); });

    //Blob size is not a whole number of vertices.
    assertThrows(function(){ ::vertexBuffer.upload(blob(BYTES_PER_VERT + 1)); });

    //Empty blob.
    assertThrows(function(){ ::vertexBuffer.upload(blob(0)); });

    //Not a blob at all.
    assertThrows(function(){ ::vertexBuffer.upload("not a blob"); });
    assertThrows(function(){ ::vertexBuffer.upload(20); });

    //--- The case this whole binding exists for ---
    //Several uploads back to back inside a single frame. map() would throw on
    //the second of these; upload() must not throw on any of them.
    for(local i = 0; i < 8; i++){
        ::vertexBuffer.upload(buildQuadBlob(i.tofloat() * 0.1));
    }

    //Sub range upload - replace just the last two vertices.
    local partial = blob(2 * BYTES_PER_VERT);
    for(local i = 0; i < 2; i++){
        partial.writen(0.0, 'f'); partial.writen(0.0, 'f'); partial.writen(0.0, 'f');
        partial.writen(0.0, 'f'); partial.writen(0.0, 'f');
    }
    ::vertexBuffer.upload(partial, 2);
    //A single vertex at the very last index is in bounds.
    ::vertexBuffer.upload(blob(BYTES_PER_VERT), NUM_VERTS - 1);

    //Uploading to a buffer that DOES keep a shadow copy must work too - that
    //path additionally memcpys into the shadow copy inside Ogre.
    ::shadowedBuffer = _graphics.createVertexBuffer(vertexElemVec, NUM_VERTS, 999, buildQuadBlob(0.0));
    _test.assertEqual(::shadowedBuffer.getNumElements(), NUM_VERTS);
    ::shadowedBuffer.upload(buildQuadBlob(2.0));
    ::shadowedBuffer.upload(buildQuadBlob(3.0), 0);

    //Restore a sane quad for the animation below.
    ::vertexBuffer.upload(buildQuadBlob(0.0));

    _camera.setPosition(0, 0, 30);
    _camera.lookAt(0, 0, 0);
}

function update(){
    //Upload every frame for a while. This crosses the engine's fixed timestep
    //boundary, including frames where the logic loop runs more than once per
    //render - exactly the situation that would throw with map().
    ::framesRun++;
    ::vertexBuffer.upload(buildQuadBlob(sin(::framesRun.tofloat() * 0.1) * 2.0));

    if(::framesRun >= 60){
        _test.endTest();
    }
}
