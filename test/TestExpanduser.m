classdef TestExpanduser < matlab.unittest.TestCase

properties(TestParameter)

p = {{'', ''}, {"", ""}, ...
{"~abc", "~abc"}, ...
{'~', stdlib.homedir()},...
{"~", string(stdlib.homedir())}, ...
{'~/', stdlib.homedir()},...
{"~" + filesep(), string(stdlib.homedir())}, ...
{"~/c", fullfile(stdlib.homedir(), "c")}, ...
{"~//c", fullfile(stdlib.homedir(), "c")}, ...
{"~" + filesep() + "c", fullfile(stdlib.homedir(), "c")}};
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods(Test, TestTags="impure")

function test_expanduser(tc, p)
tc.verifyEqual(stdlib.expanduser(p{1}), p{2})
end

end

end
