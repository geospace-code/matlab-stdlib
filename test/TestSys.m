classdef TestSys < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
fun = {@stdlib.isoctave, @stdlib.has_dotnet, ...
       @stdlib.has_java, @stdlib.has_python}
cpu_arch_fun = {@stdlib.cpu_arch, @stdlib.dotnet.cpu_arch, @stdlib.java.cpu_arch}
host_fun = {@stdlib.hostname, @stdlib.sys.get_hostname, @stdlib.dotnet.get_hostname, @stdlib.java.get_hostname, @stdlib.python.get_hostname}
user_fun = {@stdlib.get_username, @stdlib.sys.get_username, @stdlib.dotnet.get_username, @stdlib.java.get_username, @stdlib.python.get_username}
is_admin_fun = {@stdlib.is_admin, @stdlib.sys.is_admin, @stdlib.dotnet.is_admin, @stdlib.java.is_admin, @stdlib.python.is_admin}
ram_free_method = {'sys', 'java', 'python'}
ram_total_method = {'sys', 'dotnet', 'java', 'python'}
cpu_load_method = {"java", "python", "sys"}
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

function test_is_admin(tc, is_admin_fun)
is_capable(tc, is_admin_fun)
tc.verifyClass(is_admin_fun(), "logical")
tc.verifyNotEmpty(is_admin_fun())
end


function test_get_pid(tc)
pid = stdlib.get_pid();

tc.verifyGreaterThan(pid, 0)
tc.verifyClass(pid, 'uint64')
end


function test_cpu_load(tc, cpu_load_method)
n = "stdlib." + cpu_load_method + ".cpu_load";
h = @stdlib.cpu_load;
tc.assertNotEmpty(which(n))
try
  r = h(cpu_load_method);
  tc.verifyGreaterThanOrEqual(r, 0.)
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
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

function test_os_version(tc)
tc.assumeTrue(stdlib.has_dotnet() || stdlib.has_java())

[os, ver] = stdlib.os_version();
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

function test_hostname(tc, host_fun)
is_capable(tc, host_fun)
h = host_fun();
tc.verifyGreaterThan(strlength(h), 0)
end

function test_username(tc, user_fun)
is_capable(tc, user_fun)
u = user_fun();
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
is_capable(tc, cpu_arch_fun)

arch = cpu_arch_fun();
tc.verifyGreaterThan(strlength(arch), 0, "CPU architecture should not be empty")
end

function test_ram_total(tc, ram_total_method)
is_capable(tc, str2func("stdlib." + ram_total_method + ".ram_total"))

t = stdlib.ram_total(ram_total_method);
tc.verifyGreaterThan(t, 0)
tc.verifyClass(t, 'uint64')
end


function test_ram_free(tc, ram_free_method)
% don't verify less than or equal total due to shaky system measurements
is_capable(tc, str2func("stdlib." + ram_free_method + ".ram_free"))

f = stdlib.ram_free(ram_free_method);
tc.verifyGreaterThan(f, 0)
tc.verifyClass(f, 'uint64')
end

end

end
