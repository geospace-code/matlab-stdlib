classdef TestSuffix < matlab.unittest.TestCase

properties (TestParameter)
p = {{"", ""}, {"/a/b/c", ""}, ...
  {"/a/b/c/", ""}, {"a/b/c.txt", ".txt"}, ...
  {"a/b/c.txt.gz", ".gz"}, ...
  {'.stat', ".stat"}, ...
  {'.stat.txt', ".txt"}}
end

methods (Test, TestTags="pure")
function test(tc, p)
tc.verifyEqual(stdlib.suffix(p{1}), p{2})
end
end

end
