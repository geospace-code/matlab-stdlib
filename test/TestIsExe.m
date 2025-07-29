classdef TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
p = {
{fileparts(mfilename('fullpath')) + "/../Readme.md", false}, ...
{"not-exist", false}, ...
{'', false}, ...
{"", false}
}
method = {'java', 'python', 'native', 'legacy'}
end

methods(TestClassSetup)
function pkg_path(tc)
msp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(msp)
end
end

methods(Test, TestTags="impure")

function test_is_exe(tc, p, method)
is_capable(tc, str2func("stdlib." + method + ".is_exe"))

tc.verifyEqual(stdlib.is_exe(p{1}, method), p{2})
end


function test_is_exe_dir(tc, method)
is_capable(tc, str2func("stdlib." + method + ".is_exe"))

tc.verifyFalse(stdlib.is_exe('.', method))
end


function test_matlab_exe(tc, method)
is_capable(tc, str2func("stdlib." + method + ".is_exe"))


f = matlab_path();
tc.verifyTrue(stdlib.is_exe(f, method))
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
