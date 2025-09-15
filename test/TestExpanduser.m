classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017b', 'impure'}) ...
    TestExpanduser < matlab.unittest.TestCase

properties (TestParameter)
p = init_exp()
end


methods (Test)

function test_expanduser(tc, p)
tc.verifyEqual(stdlib.expanduser(p{1}), p{2})

ins = string(p{1});
ref = string(p{2});
tc.verifyEqual(stdlib.expanduser(ins), ref);
end

end

end


function p = init_exp()

if ispc
  h = getenv("USERPROFILE");
else
  h = getenv("HOME");
end

p = {
{'', ''}, ...
{'', ''}, ...
{'~abc', '~abc'}, ...
{'~', h}, ...
{'~/', h}, ...
{['~', filesep()], h}, ...
{'~/c', [h, '/c']}, ...
{'~//c', [h, '/c']}, ...
{['~', filesep(), 'c'], [h, '/c']}};

end
