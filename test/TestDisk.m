classdef TestDisk < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", "", "not-exist"}
end

methods (Test)

function test_disk_available(tc, Ps)

tc.assumeTrue(ispc() || stdlib.has_java() || stdlib.is_mex_fun("stdlib.disk_available"))

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_available(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_available(Ps), zero)
end
end


function test_disk_capacity(tc, Ps)

tc.assumeTrue(ispc() || stdlib.has_java() || stdlib.is_mex_fun("stdlib.disk_capacity"))

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_capacity(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_capacity(Ps), zero)
end
end


function test_filesystem_type(tc, Ps)

tc.assumeTrue(ispc() || stdlib.has_java())

s = stdlib.filesystem_type(Ps);
tc.verifyClass(s, 'string')
L = strlength(s);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(L, 0)
else
  tc.verifyEqual(L, 0)
end
end


function test_device(tc)

tc.assumeTrue(ispc() || stdlib.has_java())

if ispc()
  tc.verifyGreaterThan(stdlib.device(pwd()), 0)
else
  tc.assumeGreaterThanOrEqual(stdlib.java_api(), 11)

  tc.verifyEqual(stdlib.device("."), stdlib.device(pwd()))
end
end

end
end
