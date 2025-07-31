classdef TestDisk < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
Ps = {".", "", "/", getenv("SystemDrive"), "not-exist"}
Po = {mfilename("fullpath") + ".m", pwd(), ".", "", tempname()}
id_fun = {'sys', 'java', 'python'}
id_name = {"inode", "device"}
disk_ac_fun = {'sys', 'dotnet', 'java', 'python'}
disk_ac_name = {'disk_available', 'disk_capacity'}
hl_fun = {'java', 'python'}
fst_fun = {'sys', 'dotnet', 'java', 'python'}
owner_fun = {@stdlib.get_owner, @stdlib.sys.get_owner, @stdlib.dotnet.get_owner, @stdlib.java.get_owner, @stdlib.python.get_owner}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods (Test)

function test_disk_ac(tc, Ps, disk_ac_fun, disk_ac_name)
n = "stdlib." + disk_ac_fun + "." + disk_ac_name;
h = str2func("stdlib." + disk_ac_name);
tc.assertNotEmpty(which(n))

try
  r = h(Ps, disk_ac_fun);
  if stdlib.exists(Ps)
    tc.verifyGreaterThanOrEqual(r, 0)
  else
    tc.verifyEqual(r, uint64(0))
  end
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
end
end


function test_hard_link_count(tc, hl_fun)
fname = "hard_link_count";
n = "stdlib." + hl_fun + "." + fname;
h = str2func("stdlib." + fname);
tc.assertNotEmpty(which(n))
P = mfilename("fullpath") + ".m";
try
  r = h(P, hl_fun);
  tc.verifyGreaterThanOrEqual(r, 1)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
end
end


function test_filesystem_type(tc, Ps, fst_fun)
tc.assertNotEmpty(which("stdlib." + fst_fun + ".filesystem_type"))
try
  t = stdlib.filesystem_type(Ps, fst_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
  return
end
tc.verifyClass(t, 'string')

if stdlib.exists(Ps)
  tc.assumeFalse(isempty(t) && tc.CI, "Some CI block viewing their filesystem type")
  tc.assertNotEmpty(t)
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


function test_inode_device(tc, id_fun, id_name)
n = "stdlib." + id_fun + "." + id_name;
h = str2func("stdlib." + id_name);
tc.assertNotEmpty(which(n))

try
    ip = h(pwd(), id_fun);
    tc.verifyClass(ip, 'uint64')
    tc.verifyGreaterThan(ip, 0)
    tc.verifyEqual(h(".", id_fun), ip)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
end

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
