classdef TestParent < matlab.unittest.TestCase

properties (TestParameter)
p = init_parent()
end

methods (Test)
function test_parent(tc, p)
import matlab.unittest.constraints.Matches
tc.verifyThat(stdlib.parent(p{1}), Matches(p{2}), p{1})
end
end

end


function p = init_parent()

p = {
{"", "\."}, ...
{".", "\."}, ...
{"..", "\."}, ...
{"../..", "\.\."}, ...
{"a/", "\."}, ...
{"a/b", "a"}, ...
{'a/b/', 'a'}, ...
{'a//b', 'a'}, ...
{"ab/.parent", "ab"}, ...
{"ab/.parent.txt", "ab"}, ...
{"a/b/../.parent.txt", "a/b/\.\."}, ...
{"a/////b////c", "a/b"}};

if ispc
p{end+1} = {"c:/", "c:/"};
p{end+1} = {"c:\", "c:/"};
p{end+1} = {"c:/a/b", "c:/a"};
p{end+1} = {"c:\a/b", "c:/a"};
p{end+1} = {"c:/a", "c:/"};
p{end+1} = {"c:", "c:/"};
end

end
