classdef (TestTags = {'R2019b', 'impure'}) ...
    TestExpanduser < matlab.unittest.TestCase

properties(TestParameter)
p = init_exp()
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods(Test)

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
