classdef TestParent < matlab.unittest.TestCase

properties (TestParameter)
p_parent
end

methods(TestParameterDefinition, Static)

function p_parent = init_parent()

p_parent = {
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
p_parent{12}{2} = "c:/";
p_parent{13}{2} = "c:/";
p_parent{14}{2} = "c:/a";
p_parent{15}{2} = "c:/a";
p_parent{end+1} =  {"c:/a", "c:/"};
p_parent{end+1} = {"c:", "c:/"};

end

end
end


methods (Test)
function test_parent(tc, p_parent)
tc.verifyEqual(stdlib.parent(p_parent{1}), p_parent{2}, p_parent{1})
end
end

end
