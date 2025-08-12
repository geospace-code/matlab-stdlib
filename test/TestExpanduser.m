classdef TestExpanduser < matlab.unittest.TestCase

properties(TestParameter)
p = init_exp()
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods(Test, TestTags=["R2019b", "impure"])

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
{'~', h},...
{"~", string(h)}, ...
{'~/', h},...
{"~" + filesep(), string(h)}, ...
{"~/c", fullfile(h, "c")}, ...
{"~//c", fullfile(h, "c")}, ...
{"~" + filesep() + "c", fullfile(h, "c")}};

end
