classdef TestParent < matlab.unittest.TestCase

properties (TestParameter)
use_java = num2cell(unique([stdlib.has_java(), false]))
p = init_parent()
end

methods (Test)
function test_parent(tc, p, use_java)
tc.verifyEqual(stdlib.parent(p{1}, use_java), p{2}, p{1})
end
end

end


function p = init_parent()

p = {
{"", "."}, ...
{".", "."}, ...
{"..", "."}, ...
{"../..", ".."}, ...
{"a/", "."}, ...
{"a/b", "a"}, ...
{"a/b/", "a"}, ...
{"ab/.parent", "ab"}, ...
{"ab/.parent.txt", "ab"}, ...
{"a/b/../.parent.txt", "a/b/.."}, ...
{"a/////b////c", "a/b"}, ...
{"c:/", "."}, ...
{"c:\", "."}, ...
{"c:/a/b", "c:/a"}, ...
{"c:\a/b", "c:\a"}
};

if ispc
p{12}{2} = "c:/";
p{13}{2} = "c:/";
p{14}{2} = "c:/a";
p{15}{2} = "c:/a";
p{end+1} =  {"c:/a", "c:/"};
p{end+1} = {"c:", "c:/"};

end

end
