classdef TestDisk < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", "", "not-exist"}
end

methods (Test)

function test_disk_available(tc, Ps)

tc.assumeTrue(stdlib.has_dotnet() || stdlib.has_java() || stdlib.is_mex_fun("stdlib.disk_available"))

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_available(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_available(Ps), zero)
end
end


function test_disk_capacity(tc, Ps)

tc.assumeTrue(stdlib.has_dotnet() || stdlib.has_java() || stdlib.is_mex_fun("stdlib.disk_capacity"))

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_capacity(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_capacity(Ps), zero)
end
end


function test_filesystem_type(tc, Ps)

tc.assumeTrue(stdlib.has_dotnet() || stdlib.has_java())

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

tc.assumeTrue(stdlib.has_python() || (isunix() && stdlib.has_java() && stdlib.java_api() >= 11))

if ispc()
  tc.verifyGreaterThan(stdlib.device(pwd()), 0)
else
  tc.verifyEqual(stdlib.device("."), stdlib.device(pwd()))
end
end


function test_inode(tc)
tc.assumeTrue(stdlib.has_python() || (~ispc() && stdlib.has_java() && stdlib.java_api() >= 11))

tc.verifyEqual(stdlib.inode("."), stdlib.inode(pwd()))
end

end
end
