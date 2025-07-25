classdef TestDisk < matlab.unittest.TestCase

properties
disk_fun = stdlib.has_python() || stdlib.has_dotnet() || stdlib.has_java()
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
device_fun = init_device_fun()
end

methods (Test)

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


function device_fun = init_device_fun()
device_fun = {@stdlib.sys.device, @stdlib.device};

if isunix() && stdlib.java_api() > 11
  device_fun{end+1} = @stdlib.java.device;
end

if stdlib.has_python()
  device_fun{end+1} = @stdlib.python.device;
end
end
