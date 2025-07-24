classdef TestFilename < matlab.unittest.TestCase

properties (TestParameter)
p = init_p()
e = {'/a/b/c/', "/a/b/c/"}
end

methods (Test, TestTags="pure")
function test_filename(tc, p)
tc.verifyEqual(stdlib.filename(p{1}), p{2})
end

function test_filename_empty(tc, e)
tc.verifyEqual(strlength(stdlib.filename(e)), 0)
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
{"a/b/c.txt.gz", "c.txt.gz"}, ...
{"a/b/.hello", ".hello"}
};

if ispc()
  p{end+1} = {"c:/df\df.txt", "df.txt"};
end

end
