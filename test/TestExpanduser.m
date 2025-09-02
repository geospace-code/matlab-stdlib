classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2021a', 'impure'}) ...
    TestExpanduser < matlab.unittest.TestCase

properties (TestParameter)
p
end


methods (TestParameterDefinition, Static)
function p = init_exp()

if ispc
  h = getenv("USERPROFILE");
else
  h = getenv("HOME");
end
h = string(h);

p = {{'', ""}, {"", ""}, ...
{"~abc", "~abc"}, ...
{"~", h}, ...
{'~/', h},...
{"~" + filesep(), h}, ...
{"~/c", fullfile(h, "c")}, ...
{"~//c", fullfile(h, "c")}, ...
{"~" + filesep() + "c", fullfile(h, "c")}};

end
end

methods (Test)

function test_expanduser(tc, p)
tc.verifyEqual(stdlib.expanduser(p{1}), p{2})
end

end

end
