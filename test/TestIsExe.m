classdef TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
p = {
{fileparts(mfilename('fullpath')) + "/../Readme.md", false}, ...
{"not-exist", false}, ...
{'', false}, ...
{"", false}, ...
{'.', false}, ...
{matlab_path(), true}
}
backend = {'java', 'python', 'native', 'legacy'}
end

methods(TestClassSetup)
function pkg_path(tc)
msp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(msp)
end
end

methods(Test, TestTags="impure")

function test_is_exe(tc, p, backend)
try
  tc.verifyEqual(stdlib.is_exe(p{1}, backend), p{2})
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
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
