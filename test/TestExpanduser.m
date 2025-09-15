classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2019a', 'impure'}) ...
    TestExpanduser < matlab.unittest.TestCase

properties (TestParameter)
p = init_exp()
end


methods (Test)

function test_expanduser(tc, p)
tc.verifyEqual(stdlib.expanduser(p{1}), p{2})
end

end

end


function p = init_exp()

if ispc
  h = getenv("USERPROFILE");
else
  h = getenv("HOME");
end

p = {{'', ''}, {"", ""}, ...
{"~abc", "~abc"}, ...
{'~', h}, ...
{'~/', h},...
{"~" + filesep(), string(h)}, ...
{"~/c", append(h, "/c")}, ...
{'~//c', append(h, '/c')}, ...
{"~" + filesep() + "c", append(h, "/c")}};

end
