classdef TestFilename < matlab.unittest.TestCase

properties (TestParameter)
p = init_p()
e = {'/a/b/c/', "a/b/c/"}
method = {'pattern', 'regexp'}
end

methods(TestClassSetup)
function pkg_path(tc)
msp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(msp)
end
end

methods (Test, TestTags="pure")

function test_filename(tc, p, method)
fn = stdlib.filename(p{1}, method);
tc.verifyEqual(fn, p{2})
end

function test_filename_empty(tc, e, method)
fn = stdlib.filename(e, method);
tc.verifyEqual(strlength(fn), 0)
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
