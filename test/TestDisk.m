classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'R2019b', 'impure'}) ...
  TestDisk < matlab.unittest.TestCase

properties
CI = is_ci()
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
Po = {mfilename("fullpath") + ".m", pwd(), ".", "", "not-exist"}
B_disk
B_is_removable
B_is_mount
B_hard_link_count
B_filesystem_type
B_owner
B_device
end

methods (TestParameterDefinition, Static)
function [B_disk, B_is_removable, B_is_mount, B_hard_link_count, B_filesystem_type, B_owner, B_device] = setupBackends()
B_disk = init_backend("disk_available");
B_is_removable = init_backend("is_removable");
B_is_mount = init_backend("is_mount");
B_hard_link_count = init_backend("hard_link_count");
B_filesystem_type = init_backend("filesystem_type");
B_owner = init_backend("get_owner");
B_device = init_backend("device");
end
end

methods(TestClassSetup)
function test_dirs(tc)
  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end

methods (Test)

function test_disk_available(tc, Ps, B_disk)
r = stdlib.disk_available(Ps, B_disk);

tc.verifyClass(r, 'uint64')

if stdlib.exists(Ps)
  tc.verifyGreaterThanOrEqual(r, 0)
else
  tc.verifyEmpty(r)
end
end


function test_disk_capacity(tc, Ps, B_disk)
r = stdlib.disk_capacity(Ps, B_disk);

tc.verifyClass(r, 'uint64')

if stdlib.exists(Ps)
  tc.verifyGreaterThanOrEqual(r, 0)
else
  tc.verifyEmpty(r)
end
end


function test_is_removable(tc, B_is_removable)
y = stdlib.is_removable(pwd(), B_is_removable);
tc.verifyClass(y, 'logical')
end


function test_is_mount(tc, B_is_mount)
y = stdlib.is_mount(pwd(), B_is_mount);

tc.verifyClass(y, 'logical')
tc.verifyTrue(stdlib.is_mount("/", B_is_mount))
tc.verifyEmpty(stdlib.is_mount(tempname(), B_is_mount))

if ispc()
  sd = getenv("SystemDrive");
  tc.assertTrue(sd == stdlib.root_name(sd), sd)
  tc.verifyFalse(stdlib.is_mount(sd, B_is_mount), sd)
  tc.verifyTrue(stdlib.is_mount(sd + "/", B_is_mount), sd)
  tc.verifyTrue(stdlib.is_mount(sd + "\", B_is_mount), sd)
end
end


function test_hard_link_count(tc, B_hard_link_count)
P = mfilename("fullpath") + ".m";

r = stdlib.hard_link_count(P, B_hard_link_count);
tc.verifyGreaterThanOrEqual(r, 1)
end


function test_filesystem_type(tc, Ps, B_filesystem_type)
t = stdlib.filesystem_type(Ps, B_filesystem_type);
tc.verifyClass(t, 'char')

if ~stdlib.exists(Ps)
  tc.verifyEmpty(t)
else
  tc.assumeFalse(isempty(t) && tc.CI, "Some CI block viewing their filesystem type")
  tc.assertNotEmpty(t)
  tc.verifyGreaterThan(strlength(t), 0)
end
end


function test_remove_file(tc)

f = tempname();

tc.verifyFalse(stdlib.remove(f), "should not succeed at removing non-existant path")

tc.assumeTrue(stdlib.touch(f), "failed to touch file " + f)
tc.assumeThat(f, matlab.unittest.constraints.IsFile)

tc.verifyTrue(stdlib.remove(f), "failed to remove file " + f)
end


function test_device(tc, Po, B_device)
i = stdlib.device(Po, B_device);
tc.verifyClass(i, 'uint64')

if ~stdlib.exists(Po)
  tc.verifyEmpty(i)
else
  tc.assertNotEmpty(i)
  tc.assertGreaterThan(i, 0)
end
end


function test_inode(tc, Po, B_device)

i = stdlib.inode(Po, B_device);
tc.verifyClass(i, 'uint64')

if ~stdlib.exists(Po)
  tc.verifyEmpty(i)
else
  tc.assertNotEmpty(i)
  tc.assertGreaterThan(i, 0)
end
end


function test_owner(tc, Po, B_owner)
o = stdlib.get_owner(Po, B_owner);

if ~stdlib.exists(Po)
  tc.verifyEqual(o, "")
else
  tc.verifyGreaterThan(strlength(o), 0)
end

end


function test_owner_array(tc, B_owner)

o = stdlib.get_owner([".", pwd(), "not-exist", ""], B_owner);
L = strlength(o);

tc.verifyEqual(L(3:4), [0, 0])

tc.verifyGreaterThan(L(1:2), 0);

end

end
end
