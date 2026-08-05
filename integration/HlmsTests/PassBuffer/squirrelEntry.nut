//A test for the script pass buffer API on the Hlms dispatch listener.

function start(){
    //Before any buffer is declared, getPassBuffer returns null.
    _test.assertEqual(null, _hlms.pbs.getPassBuffer());

    //Declaring one returns a handle sized to the requested float count.
    local pb = _hlms.pbs.createPassBuffer(4);
    _test.assertTrue(pb != null);
    _test.assertEqual(4, pb.getSize());

    //getPassBuffer now returns the (equivalent) existing handle.
    local pb2 = _hlms.pbs.getPassBuffer();
    _test.assertTrue(pb2 != null);
    _test.assertEqual(4, pb2.getSize());

    //createPassBuffer is idempotent-with-resize.
    local pbResized = _hlms.pbs.createPassBuffer(8);
    _test.assertEqual(8, pbResized.getSize());

    //Writing values should not error.
    pb.setFloat(0, 1.5);
    pb.setVec3(1, Vec3(1, 2, 3));
    pb.setVec4(4, ColourValue(0.1, 0.2, 0.3, 0.4));

    local b = blob(3 * 4);
    b.writen(9.0, 'f'); b.writen(8.0, 'f'); b.writen(7.0, 'f');
    pb.setData(b);
    pb.setData(2, b);

    //The unlit Hlms has its own independent buffer.
    local up = _hlms.unlit.createPassBuffer(2);
    _test.assertEqual(2, up.getSize());
    up.setFloat(0, 3.0);

    _test.endTest();
}
