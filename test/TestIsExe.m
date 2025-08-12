classdef TestIsExe < matlab.unittest.TestCase

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
peb = init_exe_bin()
backend = {'java', 'python', 'native', 'legacy'}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods(Test, TestTags=["R2019b", "impure"])

function test_is_exe(tc, p, backend)
try
  tc.verifyEqual(stdlib.is_exe(p{1}, backend), p{2})
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_is_exe_array(tc, backend)
try
  n = fullfile(matlabroot, "bin/matlab");
  if ispc()
    n = n + ".exe";
  end
  r = stdlib.is_exe(["Readme.md", tempname(), n], backend);
  tc.verifyEqual(r, [false, false, true])
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end

end


function test_is_executable_binary(tc, peb)

b = stdlib.is_executable_binary(peb{1});
tc.verifyEqual(b, peb{2}, peb{1})

end
end

end


function f = matlab_path()

f = fullfile(matlabroot, "bin/matlab");
if ispc()
  f = f + ".exe";
end
end


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
