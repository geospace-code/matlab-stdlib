classdef TestSys < matlab.unittest.TestCase

properties (TestParameter)
fun = {stdlib.iscygwin, stdlib.isoctave, stdlib.is_rosetta, stdlib.isinteractive}
fi32 = {stdlib.is_wsl}
end


methods (Test, TestTags="impure")

function test_platform_logical(tc, fun)
tc.verifyClass(fun, 'logical')
end

function test_platform_int32(tc, fi32)
tc.verifyClass(fi32, 'int32')
end

function test_hostname(tc)
tc.assumeTrue(ispc() || stdlib.has_java())

h = stdlib.hostname();
tc.verifyGreaterThan(strlength(h), 0)
end

function test_username(tc)
tc.assumeTrue(ispc() || stdlib.has_java())

u = stdlib.get_username();
tc.verifyGreaterThan(strlength(u), 0)
end


function test_cpu_arch(tc)
tc.assumeTrue(ispc() || stdlib.has_java())

arch = stdlib.cpu_arch();
tc.verifyGreaterThan(strlength(arch), 0)
end

end
end
