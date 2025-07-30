classdef TestDisk < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
Po = {mfilename("fullpath") + ".m", pwd(), ".", "", tempname()}
device_fun = {@stdlib.device, @stdlib.sys.device, @stdlib.java.device, @stdlib.python.device}
inode_fun = {@stdlib.inode, @stdlib.sys.inode, @stdlib.java.inode, @stdlib.python.inode}
disk_available_fun = {@stdlib.disk_available, @stdlib.sys.disk_available, @stdlib.dotnet.disk_available, @stdlib.java.disk_available, @stdlib.python.disk_available}
disk_capacity_fun  = {@stdlib.disk_capacity,  @stdlib.sys.disk_capacity,  @stdlib.dotnet.disk_capacity,  @stdlib.java.disk_capacity,  @stdlib.python.disk_capacity}
hl_fun = {'java', 'python'}
fst_fun = {@stdlib.filesystem_type, @stdlib.sys.filesystem_type, @stdlib.dotnet.filesystem_type, @stdlib.java.filesystem_type, @stdlib.python.filesystem_type}
owner_fun = {@stdlib.get_owner, @stdlib.sys.get_owner, @stdlib.dotnet.get_owner, @stdlib.java.get_owner, @stdlib.python.get_owner}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods (Test)

function test_disk_available(tc, Ps, disk_available_fun)
is_capable(tc, disk_available_fun)

zero = uint64(0);

da = disk_available_fun(Ps);

tc.verifyClass(da, 'uint64')

if stdlib.exists(Ps)
  tc.verifyGreaterThan(da, zero)
else
  tc.verifyEqual(da, zero)
end
end


function test_disk_capacity(tc, Ps, disk_capacity_fun)
is_capable(tc, disk_capacity_fun)

zero = uint64(0);

dc = disk_capacity_fun(Ps);

tc.verifyClass(dc, 'uint64')

if stdlib.exists(Ps)
  tc.verifyGreaterThan(dc, zero)
else
  tc.verifyEqual(dc, zero)
end
end


function test_hard_link_count(tc, hl_fun)
fname = "hard_link_count";
n = "stdlib." + hl_fun + "." + fname;
h = str2func("stdlib." + fname);
tc.assertNotEmpty(which(n))
try
  tc.verifyGreaterThanOrEqual(h(mfilename("fullpath") + ".m"), 1)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError')
end
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


function test_remove_file(tc)

tc.assumeFalse(isMATLABReleaseOlderThan('R2022a'))
d = tc.createTemporaryFolder();

f = tempname(d);

tc.verifyFalse(stdlib.remove(f), "should not succeed at removing non-existant path")

tc.assumeTrue(stdlib.touch(f), "failed to touch file " + f)
tc.assumeThat(f, matlab.unittest.constraints.IsFile)

tc.verifyTrue(stdlib.remove(f), "failed to remove file " + f)
end


function test_device(tc, device_fun)
is_capable(tc, device_fun)

tc.verifyGreaterThan(device_fun(pwd()), uint64(0))
tc.verifyEqual(device_fun("."), device_fun(pwd()))

end


function test_inode(tc, inode_fun)
is_capable(tc, inode_fun)

tc.verifyEqual(inode_fun("."), inode_fun(pwd()))
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
