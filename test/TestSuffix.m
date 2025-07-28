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
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods (Test, TestTags="pure")
function test_suffix(tc, p)
tc.verifyEqual(stdlib.suffix(p{1}), p{2})
end
end

end
