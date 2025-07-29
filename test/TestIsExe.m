classdef TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
p = {
{fileparts(mfilename('fullpath')) + "/../Readme.md", false}, ...
{"not-exist", false}, ...
{'', false}, ...
{"", false}
}
fun = {@stdlib.is_exe, @stdlib.java.is_exe, @stdlib.python.is_exe, @stdlib.native.is_exe, @stdlib.native.is_exe_legacy}
end

methods(TestClassSetup)
function pkg_path(tc)
msp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(msp)
end
end

methods(Test, TestTags="impure")

function test_is_exe(tc, p, fun)
is_capable(tc, fun)

tc.verifyEqual(fun(p{1}), p{2})
end


function test_is_exe_dir(tc, fun)
is_capable(tc, fun)

tc.verifyFalse(fun('.'))
end


function test_matlab_exe(tc, fun)
is_capable(tc, fun)


f = matlab_path();
tc.verifyTrue(fun(f))
end


function test_is_executable_binary(tc)

if ispc()
  f = matlab_path();
else
  f = '/bin/ls';
end

tc.assumeThat(f, matlab.unittest.constraints.IsFile)

b = stdlib.is_executable_binary(f);
tc.assumeTrue(b, f)

end
end

end


function f = matlab_path()

f = fullfile(matlabroot, "bin/matlab");
if ispc()
  f = f + ".exe";
end
end
