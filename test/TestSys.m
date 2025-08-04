classdef TestSys < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
fun = {@stdlib.isoctave, @stdlib.has_dotnet, ...
       @stdlib.has_java, @stdlib.has_python}
cpu_arch_fun = {'java', 'dotnet', 'native'}
cr_method = {'sys', 'java', 'python'}
all_fun = {'java', 'python', 'dotnet', 'sys'}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end


methods (Test, TestTags="impure")

function test_platform_tell(tc)
tc.verifyClass(stdlib.platform_tell(), 'char')
end

function test_platform_logical(tc, fun)
tc.verifyClass(fun(), 'logical')
end

function test_is_cygwin(tc)
tc.verifyFalse(stdlib.is_cygwin())
end

function test_is_admin(tc, all_fun)
tc.assertNotEmpty(which("stdlib." + all_fun + ".is_admin"))
try
  i = stdlib.is_admin(all_fun);
  tc.verifyClass(i, "logical")
  tc.verifyNotEmpty(i)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_get_pid(tc)
pid = stdlib.get_pid();

tc.verifyGreaterThan(pid, 0)
tc.verifyClass(pid, 'uint64')
end


function test_cpu_load(tc, cr_method)
n = "stdlib." + cr_method + ".cpu_load";
h = @stdlib.cpu_load;
tc.assertNotEmpty(which(n))
try
  r = h(cr_method);
  tc.verifyGreaterThanOrEqual(r, 0.)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_get_shell(tc)
tc.assumeFalse(tc.CI, "get_shell is not tested in CI due to platform differences")
tc.verifyNotEmpty(stdlib.get_shell())
end

function test_is_interactive(tc)
if tc.CI
  tc.verifyFalse(stdlib.isinteractive())
else
  tc.verifyClass(stdlib.isinteractive(), 'logical')
end
end

function test_is_rosetta(tc)
if ismac()
  tc.verifyClass(stdlib.is_rosetta(), 'logical')
else
  tc.verifyFalse(stdlib.is_rosetta(), 'is_rosetta should be false on non-macOS systems')
end
end

function test_is_wsl(tc)
if isunix() && ~ismac()
  tc.verifyGreaterThanOrEqual(stdlib.is_wsl(), 0)
else
  tc.verifyEqual(stdlib.is_wsl(), 0)
end
end

function test_dotnet_version(tc)
tc.assumeTrue(stdlib.has_dotnet())
v = stdlib.dotnet_version();
tc.verifyTrue(stdlib.version_atleast(v, "4.0"), ".NET version should be greater than 4.0")
end

function test_has_python(tc)
tc.assumeTrue(stdlib.has_python())
v = stdlib.python_version();
tc.verifyTrue(all(v >= [3, 8, 0]), "expected Python >= 3.8")
end

function test_os_version(tc, all_fun)
try
  [os, ver] = stdlib.os_version(all_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.verifyGreaterThan(strlength(os), 0, "expected non-empty os")
tc.verifyGreaterThan(strlength(ver), 0, "expected non-empty version")
end

function test_cpu_count(tc)
tc.verifyGreaterThan(stdlib.cpu_count(), 0)
end

function test_checkRAM(tc)
tc.verifyTrue(stdlib.checkRAM(1, "double"))
end

function test_is_parallel(tc)
ip = stdlib.is_parallel_worker();
tc.verifyNotEmpty(ip)
tc.verifyClass(ip, 'logical')
end

function test_hostname(tc, all_fun)
tc.assertNotEmpty(which("stdlib." + all_fun + ".get_hostname"))
try
  h = stdlib.hostname(all_fun);
  tc.verifyGreaterThan(strlength(h), 0)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end

function test_username(tc, all_fun)
tc.assertNotEmpty(which("stdlib." + all_fun + ".get_username"))
try
  u = stdlib.get_username(all_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.verifyClass(u, 'char')
tc.verifyGreaterThan(strlength(u), 0)
end


function test_xcode_version(tc)
if ismac()
  tc.verifyNotEmpty(stdlib.xcode_version())
else
  tc.verifyEmpty(stdlib.xcode_version())
end
end


function test_cpu_arch(tc, cpu_arch_fun)

try
  arch = stdlib.cpu_arch(cpu_arch_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end
tc.verifyGreaterThan(strlength(arch), 0, "CPU architecture should not be empty")
end

function test_ram_total(tc, all_fun)
try
  t = stdlib.ram_total(all_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.verifyGreaterThan(t, 0)
tc.verifyClass(t, 'uint64')
end


function test_ram_free(tc, cr_method)
% don't verify less than or equal total due to shaky system measurements'
try
  f = stdlib.ram_free(cr_method);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

tc.verifyGreaterThan(f, 0)
tc.verifyClass(f, 'uint64')
end

end

end
