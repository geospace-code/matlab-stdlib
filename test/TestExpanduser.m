classdef (TestTags = {'impure'}) TestExpanduser < StdlibPath

properties (TestParameter)
p
end


methods (TestParameterDefinition, Static)

function p = init_exp()

if ispc()
  h = getenv('USERPROFILE');
else
  h = getenv('HOME');
end

p = {
{'', ''}, ...
{'~abc', '~abc'}, ...
{'~', h}, ...
{'~/', h}, ...
{['~', filesep()], h}, ...
{'~/c', fullfile(h, 'c')}, ...
{'~//c', fullfile(h, 'c')}, ...
{fullfile('~', 'c'), fullfile(h, 'c')}};

end

end


methods (Test)

function test_expanduser(tc, p)
tc.verifyEqual(stdlib.expanduser(p{1}), p{2})

tc.verifyEqual(stdlib.expanduser(string(p{1})), string(p{2}))
end

end

end
