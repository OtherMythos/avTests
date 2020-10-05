//A test which checks the functionality of the ray user data.

function start(){

    {
        local ray = Ray();
        _test.assertEqual(ray.getDirection(), Vec3(0));
        _test.assertEqual(ray.getOrigin(), Vec3(0));
    }

    {
        local ray = Ray(Vec3(5, 5, 5), Vec3(1, 0, 0));
        _test.assertEqual(ray.getOrigin(), Vec3(5, 5, 5));
        _test.assertEqual(ray.getDirection(), Vec3(1, 0, 0));
    }

    {
        local ray = Ray(Vec3(5, 5, 5), Vec3(1, 0, 0));
        _test.assertEqual(ray.getOrigin(), Vec3(5, 5, 5));
        _test.assertEqual(ray.getDirection(), Vec3(1, 0, 0));

        _test.assertEqual(ray.getPoint(10), Vec3(15, 5, 5));
    }

    {
        local ray = Ray(SlotPosition(0, 0, 10, 10, 10), Vec3(1, 0, 0));
        _test.assertEqual(ray.getOrigin(), Vec3(10, 10, 10));
        _test.assertEqual(ray.getDirection(), Vec3(1, 0, 0));

        _test.assertEqual(ray.getPoint(10), Vec3(20, 10, 10));
    }


    _test.endTest();
}
