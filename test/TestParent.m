classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a'}) ...
    TestParent < matlab.unittest.TestCase

properties (TestParameter)
p = init_parent()
end


methods (Test)

function test_parent(tc, p)
pr = stdlib.parent(p{1});
tc.verifyEqual(pr, p{2}, sprintf('parent(%s)', p{1}))

if ~stdlib.matlabOlderThan('R2017b')
  tc.verifyEqual(stdlib.parent(string(p{1})), string(p{2}))
end

end

end
end


function p = init_parent()

p = {
{'', '.'}, ...
{'.', '.'}, ...
{'..', '.'}, ...
{'../..', '..'}, ...
{'a/', '.'}, ...
{'a/b', 'a'}, ...
{'ab/.parent', 'ab'}, ...
{'ab/.parent.txt', 'ab'}, ...
{'a/b/../.parent.txt', 'a/b/..'}};

if ispc
p{end+1} = {'c:/', 'c:/'};
p{end+1} = {'c:\', 'c:/'};
p{end+1} = {'c:/a/b', 'c:/a'};
p{end+1} = {'c:\a/b', 'c:/a'};
p{end+1} = {'c:/a', 'c:/'};
p{end+1} = {'c:', 'c:/'};
end

p{end+1} = {'a/b/', 'a'};
p{end+1} = {'a//b', 'a'};

end
