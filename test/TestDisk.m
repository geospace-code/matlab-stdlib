classdef (TestTags = {'R2019b', 'impure'}) ...
  TestDisk < matlab.unittest.TestCase

properties
CI = is_ci()
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
Po = {mfilename("fullpath") + ".m", pwd(), ".", "", "not-exist"}
backend_jps = init_backend({'sys', 'java', 'python'})
id_name = {"inode", "device"}
backend_djps = init_backend({'sys', 'dotnet', 'java', 'python'})
disk_ac_name = {'disk_available', 'disk_capacity'}
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

function test_disk_ac(tc, Ps, backend_djps, disk_ac_name)
h = str2func("stdlib." + disk_ac_name);

r = h(Ps, backend_djps);
if stdlib.exists(Ps)
  tc.verifyGreaterThanOrEqual(r, 0)
else
  tc.verifyEqual(r, uint64(0))
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
tc.verifyFalse(stdlib.is_mount(tempname(), backend_ps))

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


function test_inode_device(tc, backend_jps, id_name)

h = str2func("stdlib." + id_name);

ip = h(pwd(), backend_jps);
tc.verifyClass(ip, 'uint64')

if ispc() && backend_jps == "java"
  tc.verifyEmpty(ip)
else
  tc.assertGreaterThan(ip, 0)
  tc.verifyEqual(h(".", backend_jps), ip)
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
