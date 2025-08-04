classdef TestStem < matlab.unittest.TestCase

properties (TestParameter)

p = {...
{"/a/b/c", "c"}, ...
{"/a/b/c/", ""}, ...
{"a/b/c/", ""}, ...
{"a/b/c.txt", "c"}, ...
{"a/b/c.txt.gz", "c.txt"}, ...
{"a/b/.c", ".c"}, ...
{'a/b/.c', ".c"}, ...
{".config", ".config"}, ...
{"", ""}, ...
{'', ""}
}

end

methods(TestClassSetup)
function pkg_path(tc)
fsp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(fsp)
end
end

methods (Test, TestTags="pure")
function test_stem(tc, p)
tc.verifyEqual(stdlib.stem(p{1}), p{2})
end

function test_stem_array(tc)
in = ["", ".txt", "a/b/c.txt", "a/b/c.txt.gz", "a/b/c"];
exp = ["", ".txt", "c", "c.txt", "c"];
out = stdlib.stem(in);
tc.verifyEqual(out, exp)
end

end

end
