classdef (TestTags = {'pure'}) ...
    TestStem < matlab.unittest.TestCase

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
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test, TestTags={'R2019b'})

function test_stem(tc, p)
tc.verifyEqual(stdlib.stem(p{1}), p{2})
end

end

methods (Test, TestTags={'R2020b'})

function test_stem_array(tc)
tc.assumeFalse(stdlib.matlabOlderThan('R2020b'))
in = ["", ".txt", "a/b/c.txt", "a/b/c.txt.gz", "a/b/c"];
exp = ["", ".txt", "c", "c.txt", "c"];
out = stdlib.stem(in);
tc.verifyEqual(out, exp)
end

end

end
