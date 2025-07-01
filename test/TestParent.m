classdef TestParent < matlab.unittest.TestCase

properties (TestParameter)
p = init_parent()
end

methods (Test, TestTags="pure")

function test_parent(tc, p)
  r = p{2};

  tc.verifyEqual(stdlib.parent(p{1}), r, sprintf("mex: %d", stdlib.is_mex_fun("stdlib.parent")))
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
{"ab/.parent", "ab"}, ...
{"ab/.parent.txt", "ab"}, ...
{"a/b/../.parent.txt", fullfile("a", "b", "..")}};

if ispc
p{end+1} = {"c:/", "c:\"};
p{end+1} = {"c:\", "c:\"};
p{end+1} = {"c:/a/b", "c:\a"};
p{end+1} = {"c:\a/b", "c:\a"};
p{end+1} = {"c:/a", "c:\"};
p{end+1} = {"c:", "c:\"};
end

p{end+1} = {'a/b/', 'a'};
p{end+1} = {'a//b', 'a'};

end
