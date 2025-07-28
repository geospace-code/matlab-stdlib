classdef TestExpanduser < matlab.unittest.TestCase

properties(TestParameter)
p = init_exp()
end

methods(TestClassSetup)
function pkg_path(tc)
fsp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(fsp)
end
end

methods(Test, TestTags="impure")

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
