classdef (TestTags = {'R2019b', 'impure'}) ...
  TestDisk < matlab.unittest.TestCase

properties
CI = is_ci()
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
Po = {mfilename("fullpath") + ".m", pwd(), ".", "", "not-exist"}
backend_jps = init_backend({'sys', 'java', 'python'})
backend_djps = init_backend({'sys', 'dotnet', 'java', 'python'})
backend_ds = init_backend({'dotnet', 'sys'})
backend_ps = init_backend({'python', 'sys'})
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)

  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end

methods (Test)

function test_disk_available(tc, Ps, backend_djps)
r = stdlib.disk_available(Ps, backend_djps);

tc.verifyClass(r, 'uint64')

if stdlib.exists(Ps)
  tc.verifyGreaterThanOrEqual(r, 0)
else
  tc.verifyEmpty(r)
end
end


function test_disk_capacity(tc, Ps, backend_djps)
r = stdlib.disk_capacity(Ps, backend_djps);

tc.verifyClass(r, 'uint64')

if stdlib.exists(Ps)
  tc.verifyGreaterThanOrEqual(r, 0)
else
  tc.verifyEmpty(r)
end
end


function test_is_removable(tc, backend_ds)
y = stdlib.is_removable(pwd(), backend_ds);
tc.verifyClass(y, 'logical')
end


function test_is_mount(tc, backend_ps)
y = stdlib.is_mount(pwd(), backend_ps);

tc.verifyClass(y, 'logical')
tc.verifyTrue(stdlib.is_mount("/", backend_ps))
tc.verifyEmpty(stdlib.is_mount(tempname(), backend_ps))

if ispc()
  sd = getenv("SystemDrive");
  tc.assertTrue(sd == stdlib.root_name(sd), sd)
  tc.verifyFalse(stdlib.is_mount(sd, backend_ps), sd)
  tc.verifyTrue(stdlib.is_mount(sd + "/", backend_ps), sd)
  tc.verifyTrue(stdlib.is_mount(sd + "\", backend_ps), sd)
end
end


function test_hard_link_count(tc, backend_jps)
P = mfilename("fullpath") + ".m";

r = stdlib.hard_link_count(P, backend_jps);
if ispc() && backend_jps == "java"
  tc.verifyEmpty(r)
else
  tc.verifyGreaterThanOrEqual(r, 1)
end
end


function test_filesystem_type(tc, Ps, backend_djps)
t = stdlib.filesystem_type(Ps, backend_djps);
tc.verifyClass(t, 'char')

if ~stdlib.exists(Ps) || (backend_djps == "python" && ~stdlib.python.has_psutil())
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


function test_device(tc, Po, backend_jps)

i = stdlib.device(Po, backend_jps);
tc.verifyClass(i, 'uint64')

if ispc() && backend_jps == "java" || ~stdlib.exists(Po)
  tc.verifyEmpty(i)
else
  tc.assertNotEmpty(i)
  tc.assertGreaterThan(i, 0)
end
end


function test_inode(tc, Po, backend_jps)

i = stdlib.inode(Po, backend_jps);
tc.verifyClass(i, 'uint64')

if ispc() && backend_jps == "java" || ~stdlib.exists(Po)
  tc.verifyEmpty(i)
else
  tc.assertNotEmpty(i)
  tc.assertGreaterThan(i, 0)
end
end


function test_owner(tc, Po, backend_djps)

o = stdlib.get_owner(Po, backend_djps);

if ~stdlib.exists(Po) || ...
    (backend_djps == "dotnet" && isunix()) || ...
    (backend_djps == "python" && ispc())
  tc.verifyEqual(o, "")
else
  tc.verifyGreaterThan(strlength(o), 0)
end

end


function test_owner_array(tc, backend_djps)

o = stdlib.get_owner([".", pwd(), "not-exist", ""], backend_djps);
L = strlength(o);

tc.verifyEqual(L(3:4), [0, 0])

if (backend_djps == "dotnet" && isunix()) || ...
   (backend_djps == "python" && ispc())
  tc.verifyEqual(L(1:2), [0, 0])
else
  tc.verifyGreaterThan(L(1:2), 0);
end

end

end
end
