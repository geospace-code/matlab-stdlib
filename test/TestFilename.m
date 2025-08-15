classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'R2019b', 'pure'}) ...
    TestFilename < matlab.unittest.TestCase

properties (TestParameter)
p = init_p()
backend = init_backend()
end


methods (Test)

function test_filename(tc, p, backend)
fn = stdlib.filename(p{1}, backend);
tc.verifyEqual(fn, p{2})
end

function test_filename_array(tc, backend)
in = ["", "a", "a/b/c", "a/b/", "a/b/c.txt", "a/b/.hidden", "a/b/c/"];
exp = ["", "a", "c",    "",     "c.txt",     ".hidden", ""];
out = stdlib.filename(in, backend);
tc.verifyEqual(out, exp)
end

end

end

function p = init_p()
p = {
{'', ""}, ...
{"", ""}, ...
{"Hi", "Hi"}, ...
{"/a/b/c", "c"}, ...
{'a/b/c.txt', "c.txt"}, ...
{"a///b//c.txt.gz", "c.txt.gz"}, ...
{"a/b/.hello", ".hello"}
};

if ispc()
  p{end+1} = {"c:/df\df.txt", "df.txt"};
end

end


function backend = init_backend()

backend = {'regexp'};

try %#ok<TRYNC>
  if ~isMATLABReleaseOlderThan('R2020b')
    backend{end+1} = 'pattern';
  end
end

end
