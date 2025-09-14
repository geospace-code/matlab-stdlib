classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2019b', 'pure'}) ...
    TestFilename < matlab.unittest.TestCase

properties (TestParameter)
p = init_p()
backend = {'regexp'}
end


methods (Test)

function test_filename(tc, p, backend)
fn = stdlib.filename(p{1}, backend);
tc.verifyEqual(fn, p{2})
end

end

end


function p = init_p()
p = {
{'', ''}, ...
{"", ""}, ...
{"Hi", "Hi"}, ...
{"/a/b/c", "c"}, ...
{'a/b/c.txt', 'c.txt'}, ...
{"a///b//c.txt.gz", "c.txt.gz"}, ...
{"a/b/.hello", ".hello"}
};

if ispc()
  p{end+1} = {"c:/df\df.txt", "df.txt"};
end
end
