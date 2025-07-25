classdef TestDisk < matlab.unittest.TestCase

properties
disk_fun = stdlib.has_python() || stdlib.has_dotnet() || stdlib.has_java()
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
device_fun = {@stdlib.device, @stdlib.sys.device, @stdlib.java.device, @stdlib.python.device}
disk_available_fun = {@stdlib.disk_available, @stdlib.sys.disk_available, @stdlib.dotnet.disk_available, @stdlib.java.disk_available, @stdlib.python.disk_available}
disk_capacity_fun  = {@stdlib.disk_capacity,  @stdlib.sys.disk_capacity,  @stdlib.dotnet.disk_capacity,  @stdlib.java.disk_capacity,  @stdlib.python.disk_capacity}
end

methods (Test)

function test_disk_available(tc, Ps, disk_available_fun)
is_capable(tc, disk_available_fun)

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(disk_available_fun(Ps), zero)
else
  tc.verifyEqual(disk_available_fun(Ps), zero)
end
end


function test_disk_capacity(tc, Ps, disk_capacity_fun)
is_capable(tc, disk_capacity_fun)

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(disk_capacity_fun(Ps), zero)
else
  tc.verifyEqual(disk_capacity_fun(Ps), zero)
end
end


function test_hard_link_count(tc)
tc.assumeTrue(stdlib.has_python() || (isunix() && stdlib.has_java()))
fn = mfilename("fullpath") + ".m";

tc.verifyGreaterThanOrEqual(stdlib.hard_link_count(fn), 1)
end


function test_filesystem_type(tc, Ps)

s = stdlib.filesystem_type(Ps);
tc.verifyClass(s, 'string')
L = strlength(s);

tc.assumeFalse(isempty(L) && tc.CI, "Some CI block viewing their filesystem type")


if stdlib.exists(Ps)
  tc.verifyGreaterThan(L, 0)
else
  tc.verifyEqual(L, 0)
end
end


function test_device(tc, device_fun)
is_capable(tc, device_fun)

if ispc()
  tc.verifyGreaterThan(device_fun(pwd()), 0)
else
  tc.verifyEqual(device_fun("."), device_fun(pwd()))
end
end


function test_inode(tc)

tc.verifyEqual(stdlib.inode("."), stdlib.inode(pwd()))
end


function test_owner(tc)

s = stdlib.get_owner(mfilename("fullpath") + ".m");

tc.verifyClass(s, 'string')
tc.verifyGreaterThan(strlength(s), 0)
end

end
end
