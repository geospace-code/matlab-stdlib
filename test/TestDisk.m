classdef TestDisk < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
Po = {mfilename("fullpath") + ".m", pwd(), ".", "", "not-exist"}
java_python_sys = {'sys', 'java', 'python'}
id_name = {"inode", "device"}
all_fun = {'sys', 'dotnet', 'java', 'python'}
disk_ac_name = {'disk_available', 'disk_capacity'}
is_remove = {'dotnet', 'sys'}
py_sys = {'python', 'sys'}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test, TestTags=["R2019b", "impure"])

function test_disk_ac(tc, Ps, all_fun, disk_ac_name)
n = "stdlib." + all_fun + "." + disk_ac_name;
h = str2func("stdlib." + disk_ac_name);
tc.assertNotEmpty(which(n))

try
  r = h(Ps, all_fun);
  if stdlib.exists(Ps)
    tc.verifyGreaterThanOrEqual(r, 0)
  else
    tc.verifyEqual(r, uint64(0))
  end
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_is_removable(tc, is_remove)
try
  y = stdlib.is_removable(pwd(), is_remove);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.verifyClass(y, 'logical')
end


function test_is_mount(tc, py_sys)
try
  y = stdlib.is_mount(pwd(), py_sys);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.verifyClass(y, 'logical')
tc.verifyTrue(stdlib.is_mount("/", py_sys))
tc.verifyFalse(stdlib.is_mount(tempname(), py_sys))

if ispc()
  sd = getenv("SystemDrive");
  tc.assertTrue(sd == stdlib.root_name(sd), sd)
  tc.verifyFalse(stdlib.is_mount(sd, py_sys), sd)
  tc.verifyTrue(stdlib.is_mount(sd + "/", py_sys), sd)
  tc.verifyTrue(stdlib.is_mount(sd + "\", py_sys), sd)
end
end


function test_hard_link_count(tc, java_python_sys)
fname = "hard_link_count";
n = "stdlib." + java_python_sys + "." + fname;
h = str2func("stdlib." + fname);
tc.assertNotEmpty(which(n))
P = mfilename("fullpath") + ".m";
try
  r = h(P, java_python_sys);
  tc.verifyGreaterThanOrEqual(r, 1)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_filesystem_type(tc, Ps, all_fun)
tc.assertNotEmpty(which("stdlib." + all_fun + ".filesystem_type"))
try
  t = stdlib.filesystem_type(Ps, all_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end
tc.verifyClass(t, 'char')

if stdlib.exists(Ps)
  tc.assumeFalse(isempty(t) && tc.CI, "Some CI block viewing their filesystem type")
  tc.assertNotEmpty(t)
  tc.verifyGreaterThan(strlength(t), 0)
else
  tc.verifyEmpty(t)
end
end


function test_remove_file(tc)

f = tempname();

tc.verifyFalse(stdlib.remove(f), "should not succeed at removing non-existant path")

tc.assumeTrue(stdlib.touch(f), "failed to touch file " + f)
tc.assumeThat(f, matlab.unittest.constraints.IsFile)

tc.verifyTrue(stdlib.remove(f), "failed to remove file " + f)
end


function test_inode_device(tc, java_python_sys, id_name)
n = "stdlib." + java_python_sys + "." + id_name;
h = str2func("stdlib." + id_name);
tc.assertNotEmpty(which(n))

try
    ip = h(pwd(), java_python_sys);
    tc.verifyClass(ip, 'uint64')
    tc.verifyGreaterThan(ip, 0)
    tc.verifyEqual(h(".", java_python_sys), ip)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end

end


function test_owner(tc, Po, all_fun)
tc.assertNotEmpty(which("stdlib." + all_fun + ".get_owner"))

try
  o = stdlib.get_owner(Po, all_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.verifyClass(o, 'char')

if stdlib.exists(Po)
  tc.verifyGreaterThan(strlength(o), 0)
else
  tc.verifyEmpty(o)
end

end

end
end
