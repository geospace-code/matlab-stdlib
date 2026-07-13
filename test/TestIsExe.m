classdef (TestTags = {'pure'}) TestIsExe < WorkingClassDir

properties (TestParameter)
% we don't test plain files like Readme.md b/c some systems like Matlab Online
% have permissions like 777 everywhere
p = {
{'not-exist', false}, ...
{'', false}, ...
{'.', false}, ...
{matlab_path(), true}
}
peb = {{matlab_path(), ispc()}; ...
{'/bin/ls', ~ispc()}; ...
{tempname(), false}
};
end


methods(Test)

function test_is_exe(tc, p)
if isfile(p{1})
  r = stdlib.is_exe(p{1});
  tc.verifyEqual(r, p{2})
else
  if ~strlength(p{1})
    e = 'MATLAB:validators:mustBeNonzeroLengthText';
  else
    e = 'MATLAB:validators:mustBeFile';
  end
  tc.verifyError(@() stdlib.is_exe(p{1}), e)
end
end

function test_is_executable_binary(tc, peb)
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
