classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2016a', 'pure'}) ...
    TestIsExe < matlab.unittest.TestCase

properties (TestParameter)
% we don't test plain files like Readme.md b/c some systems like Matlab Online
% have permissions like 777 everywhere
p = {
{'not-exist', false}, ...
{'', false}, ...
{'.', false}, ...
{matlab_path(), true}
}
peb = init_exe_bin()
end


methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end


methods(Test)

function test_is_exe(tc, p)
r = stdlib.is_exe(p{1});
tc.verifyEqual(r, p{2})
end


function test_is_executable_binary(tc, peb)
tc.assumeFalse(stdlib.matlabOlderThan('R2018a'), 'hex literals not supported < R2018a')
b = stdlib.is_executable_binary(peb{1});
tc.verifyEqual(b, peb{2}, peb{1})
end

end
end

%% Helper functions

function f = matlab_path()
f = fullfile(matlabroot, 'bin/matlab');
if ispc()
  f = [f, '.exe'];
end
end


function peb = init_exe_bin()
peb = {
{matlab_path(), false}; ...
{'/bin/ls', true}; ...
{tempname(), false}
};

if ispc
  peb{1}{2} = true;
  peb{2}{2} = false;
end
end
