classdef TestSuffix < matlab.unittest.TestCase

properties (TestParameter)
p = {{"", ""}, {"/a/b/c", ""}, ...
  {"/a/b/c/", ""}, {"a/b/c.txt", ".txt"}, ...
  {"a/a.b/hi.txt", ".txt"}, ...
  {"a/a.b/matlab", ""}, ...
  {"a/b/c.txt.gz", ".gz"}, ...
  {'.stat', ""}, ...
  {'a/.stat', ""}, ...
  {'.stat.txt', ".txt"}}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test, TestTags=["R2019b", "pure"])
function test_suffix(tc, p)
tc.verifyEqual(stdlib.suffix(p{1}), p{2})
end

function test_suffix_array(tc)
in = ["", ".txt", "a/b/c.txt", "a/b/c.txt.gz", "a/b/c"];
exp = ["", "", ".txt", ".gz", ""];
out = stdlib.suffix(in);
tc.verifyEqual(out, exp)
end
end

end
