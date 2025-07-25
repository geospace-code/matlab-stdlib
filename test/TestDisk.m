classdef TestDisk < matlab.unittest.TestCase

properties
disk_fun = stdlib.has_python() || stdlib.has_dotnet() || stdlib.has_java()
end

properties (TestParameter)
Ps = {".", "", "not-exist"}
end

methods (Test)

function test_disk_available(tc, Ps)

tc.assumeTrue(tc.disk_fun || stdlib.is_mex_fun("stdlib.disk_available"))

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_available(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_available(Ps), zero)
end
end


function test_disk_capacity(tc, Ps)

tc.assumeTrue(tc.disk_fun || stdlib.is_mex_fun("stdlib.disk_capacity"))

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_capacity(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_capacity(Ps), zero)
end
end


function test_hard_link_count(tc)
tc.assumeTrue(stdlib.has_python() || (isunix() && stdlib.has_java()))
fn = mfilename("fullpath") + ".m";

tc.verifyGreaterThanOrEqual(stdlib.hard_link_count(fn), 1)
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

if ispc()
  tc.verifyGreaterThan(stdlib.device(pwd()), 0)
else
  tc.verifyEqual(stdlib.device("."), stdlib.device(pwd()))
end
end


function test_inode(tc)
tc.assumeTrue(stdlib.has_python() || (isunix() && stdlib.java_api() >= 11))

tc.verifyEqual(stdlib.inode("."), stdlib.inode(pwd()))
end


function test_owner(tc)
tc.assumeTrue((~ispc() && stdlib.has_python()) || stdlib.has_java())

s = stdlib.get_owner(".");

tc.verifyClass(s, 'string')
tc.verifyGreaterThan(strlength(s), 0)
end

end
end
