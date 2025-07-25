classdef TestSys < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end

properties (TestParameter)
fun = {stdlib.isoctave, stdlib.has_dotnet, ...
       stdlib.has_java, stdlib.has_python}
cpu_arch_fun = {@stdlib.cpu_arch, @stdlib.dotnet.cpu_arch, @stdlib.java.cpu_arch}
ram_free_fun = {@stdlib.ram_free, @stdlib.sys.ram_free, @stdlib.java.ram_free, @stdlib.python.ram_free}
ram_total_fun = {@stdlib.ram_total, @stdlib.sys.ram_total, @stdlib.dotnet.ram_total @stdlib.java.ram_total}
end


methods (Test, TestTags="impure")

function test_platform_logical(tc, fun)
tc.verifyClass(fun, 'logical')
end

function test_is_cygwin(tc)
tc.verifyFalse(stdlib.is_cygwin())
end

function test_get_shell(tc)
tc.assumeFalse(tc.CI, "get_shell is not tested in CI due to platform differences")
tc.verifyNotEmpty(stdlib.get_shell())
end

function test_is_interactive(tc)
tc.verifyNotEqual(stdlib.isinteractive(), tc.CI)
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
tc.assumeTrue(ispc() || stdlib.has_java())

tc.verifyClass(stdlib.checkRAM(1, "double"), "logical")
end

function test_is_parallel(tc)
tc.verifyClass(stdlib.is_parallel_worker(), 'logical')
end

function test_hostname(tc)
tc.assumeTrue(stdlib.has_dotnet() || stdlib.has_java() || stdlib.has_python())

h = stdlib.hostname();
tc.verifyGreaterThan(strlength(h), 0)
end

function test_username(tc)
u = stdlib.get_username();
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

function test_ram_total(tc, ram_total_fun)
is_capable(tc, ram_total_fun)

t = ram_total_fun();
tc.verifyGreaterThan(t, 0)
tc.verifyClass(t, 'uint64')
end


function test_ram_free(tc, ram_free_fun)
% don't verify less than or equal total due to shaky system measurements
is_capable(tc, ram_free_fun)

f = ram_free_fun();
tc.verifyGreaterThan(f, 0)
tc.verifyClass(f, 'uint64')
end

end

end

