classdef TestSuffix < matlab.unittest.TestCase

properties (TestParameter)
p = {{"", ""}, {"/a/b/c", ""}, ...
  {"/a/b/c/", ""}, {"a/b/c.txt", ".txt"}, ...
  {"a/b/c.txt.gz", ".gz"}, {".stat", ".stat"}, ...
  {".stat.txt", ".txt"}, ...
  {"file:///", ""}}
end

methods (Test)
function test(tc, p)
tc.verifyEqual(stdlib.suffix(p{1}), p{2})
end
end

end
