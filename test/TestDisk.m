classdef TestDisk < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
Po = {mfilename("fullpath") + ".m", pwd(), ".", "", tempname()}
device_fun = {@stdlib.device, @stdlib.sys.device, @stdlib.java.device, @stdlib.python.device}
disk_available_fun = {@stdlib.disk_available, @stdlib.sys.disk_available, @stdlib.dotnet.disk_available, @stdlib.java.disk_available, @stdlib.python.disk_available}
disk_capacity_fun  = {@stdlib.disk_capacity,  @stdlib.sys.disk_capacity,  @stdlib.dotnet.disk_capacity,  @stdlib.java.disk_capacity,  @stdlib.python.disk_capacity}
fst_fun = {@stdlib.filesystem_type, @stdlib.sys.filesystem_type, @stdlib.dotnet.filesystem_type, @stdlib.java.filesystem_type, @stdlib.python.filesystem_type}
owner_fun = {@stdlib.get_owner, @stdlib.sys.get_owner, @stdlib.dotnet.get_owner, @stdlib.java.get_owner, @stdlib.python.get_owner}
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


function test_filesystem_type(tc, Ps, fst_fun)
is_capable(tc, fst_fun)

t = fst_fun(Ps);
tc.verifyClass(t, 'string')

tc.assumeFalse(isempty(t) && tc.CI, "Some CI block viewing their filesystem type")

if stdlib.exists(Ps)
  tc.verifyGreaterThan(strlength(t), 0)
else
  tc.verifyEmpty(t)
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


function test_owner(tc, Po, owner_fun)
is_capable(tc, owner_fun)

s = owner_fun(Po);

tc.verifyClass(s, 'string')

if stdlib.exists(Po)
  tc.verifyGreaterThan(strlength(s), 0)
else
  tc.verifyEmpty(s)
end

end

end
end
