classdef TestSys < matlab.unittest.TestCase

properties (TestParameter)
fun = {stdlib.iscygwin, stdlib.isoctave, stdlib.is_rosetta, stdlib.isinteractive, stdlib.has_dotnet, ...
       stdlib.has_java, stdlib.has_python}
fi32 = {stdlib.is_wsl}
end


methods (Test, TestTags="impure")

function test_platform_logical(tc, fun)
tc.verifyClass(fun, 'logical')
end

function test_platform_int32(tc, fi32)
tc.verifyClass(fi32, 'int32')
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
tc.assumeTrue(stdlib.has_dotnet() || stdlib.has_java())

u = stdlib.get_username();
tc.verifyGreaterThan(strlength(u), 0)
end

function test_cpu_arch(tc)

arch = stdlib.cpu_arch();
tc.verifyGreaterThan(strlength(arch), 0, "CPU architecture should not be empty")
end

function test_ram_total(tc)

t = stdlib.ram_total();
tc.verifyGreaterThan(t, 0)
tc.verifyClass(t, 'uint64')
end


function test_ram_free(tc)

f = stdlib.ram_free();
tc.verifyGreaterThan(f, 0)
tc.verifyClass(f, 'uint64')
end

function test_ram_free_vs_total(tc)
t = stdlib.ram_total();
tc.assumeGreaterThan(t, 0)
f = stdlib.ram_free();
tc.assumeGreaterThan(f, 0)

tc.verifyLessThanOrEqual(f, t, "Free RAM should be less than or equal to total RAM")
end

end

end
