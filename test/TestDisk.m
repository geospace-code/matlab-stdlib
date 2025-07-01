classdef TestDisk < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", "", "not-exist"}
end

methods(Test, TestTags = "mex")

function test_mex_disk_available(tc)
tc.assertTrue(stdlib.is_mex_fun("stdlib.disk_available"))
end

function test_mex_disk_capacity(tc)
tc.assertTrue(stdlib.is_mex_fun("stdlib.disk_capacity"))
end

end

methods (Test, TestTags = "java")

function test_disk_available(tc, Ps)

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_available(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_available(Ps), zero)
end
end

function test_disk_capacity(tc, Ps)

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_capacity(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_capacity(Ps), zero)
end
end

end
end
