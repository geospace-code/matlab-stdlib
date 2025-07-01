classdef TestFilename < matlab.unittest.TestCase

properties (TestParameter)
p = {
{'', ''}, ...
{"", ""}, ...
{"/a/b/c", "c"}, ...
{'/a/b/c/', ''}, ...
{'a/b/c.txt', 'c.txt'}, ...
{"a/b/c.txt.gz", "c.txt.gz"}, ...
};
end

methods (Test, TestTags="pure")
function test_filename(tc, p)
tc.verifyEqual(stdlib.filename(p{1}), p{2})
end
end

end
