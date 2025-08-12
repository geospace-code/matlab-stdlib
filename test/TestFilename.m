classdef TestFilename < matlab.unittest.TestCase

properties (TestParameter)
p = init_p()
e = {'/a/b/c/', "a/b/c/"}
backend = {'pattern', 'regexp'}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test, TestTags=["R2019b", "pure"])

function test_filename(tc, p, backend)
fn = stdlib.filename(p{1}, backend);
tc.verifyEqual(fn, p{2})
end

function test_filename_empty(tc, e, backend)
fn = stdlib.filename(e, backend);
tc.verifyEqual(strlength(fn), 0)
end

function test_filename_array(tc, backend)
in = ["", "a", "a/b/c", "a/b/c.txt", "a/b/.hidden", "a/b/c/"];
exp = ["", "a", "c", "c.txt", ".hidden", ""];
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
