classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'pure'}) ...
    TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
% we don't test plain files like Readme.md b/c some systems like Matlab Online
% have permissions like 777 everywhere
p = {
{"not-exist", false}, ...
{'', false}, ...
{"", false}, ...
{'.', false}, ...
{matlab_path(), true}
}
peb
end


methods (TestParameterDefinition, Static)
function peb = init_exe_bin()
peb = {
{fileparts(mfilename('fullpath')) + "/../Readme.md", false}; ...
{matlab_path, false}; ...
{'/bin/ls', true}; ...
{tempname(), false}
};

if ispc
  peb{2}{2} = true;
  peb{3}{2} = false;
end
end
end

methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end

methods(Test, TestTags={'R2021a'})

function test_is_exe(tc, p)
r = stdlib.is_exe(p{1});
tc.verifyEqual(r, p{2})
end


function test_is_exe_legacy(tc, p)
r = stdlib.legacy.is_exe(p{1});
tc.verifyEqual(r, p{2})
end


function test_is_executable_binary(tc, peb)
b = stdlib.is_executable_binary(peb{1});
tc.verifyEqual(b, peb{2}, peb{1})
end
end


methods (Test, TestTags={'R2025a'})
function test_is_exe_array(tc)
tc.assumeFalse(isMATLABReleaseOlderThan('R2025a'))
n = fullfile(matlabroot, "bin/matlab");
if ispc()
  n = n + ".exe";
end
r = stdlib.is_exe(["Readme.md", tempname(), n]);
tc.verifyEqual(r, [false, false, true])
end
end

end


function f = matlab_path()
f = fullfile(matlabroot, "bin/matlab");
if ispc()
  f = f + ".exe";
end
end
