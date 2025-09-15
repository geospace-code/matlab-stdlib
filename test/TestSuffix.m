classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017b', 'pure'}) ...
    TestSuffix < matlab.unittest.TestCase

properties (TestParameter)
p = {{"", ""}, {"/a/b/c", ""}, ...
  {"/a/b/c/", ""}, {"a/b/c.txt", ".txt"}, ...
  {"a/a.b/hi.txt", ".txt"}, ...
  {"a/a.b/matlab", ""}, ...
  {"a/b/c.txt.gz", ".gz"}, ...
  {'.stat', ''}, ...
  {'a/.stat', ''}, ...
  {'.stat.txt', '.txt'}}
end


methods (Test)

function test_suffix(tc, p)
r = stdlib.suffix(p{1});
if isempty(p{2})
  tc.verifyEmpty(r)
else
  tc.verifyEqual(r, p{2})
end
end

end


end
