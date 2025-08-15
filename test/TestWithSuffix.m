classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'pure'}) ...
    TestWithSuffix < matlab.unittest.TestCase


properties (TestParameter)
p = {{"foo.h5", ".nc", "foo.nc"},...
{"c", "", "c"}, ...
{"c.nc", "", "c"}, ...
{"", ".nc", ".nc"}, ...
{"hello.txt.gz", ".bz", "hello.txt.bz"}, ...
{"a/b.c/hello.txt", ".gz", "a/b.c/hello.gz"}, ...
{'a/b/', '.h5', "a/b/.h5"}, ...
{"a/b/.h5", '.nc', "a/b/.h5.nc"}, ...
{".h5", ".nc", ".h5.nc"}, ...
{'a/b', '.nc', "a/b.nc"}};
end


methods (Test, TestTags={'R2019b'})
function test_with_suffix(tc, p)

r = p{3};

tc.verifyEqual(stdlib.with_suffix(p{1}, p{2}), r)
end
end


methods (Test, TestTags={'R2020b'})

function test_with_suffix_array(tc)
tc.assumeFalse(stdlib.matlabOlderThan('R2020b'))
in = ["", ".txt", "a/b/c.txt", "a/b/c.txt.gz", "a/b/c"];
new = [".txt", ".gz", "", ".bz", ".nc"];
exp = [".txt", ".txt.gz", "a/b/c", "a/b/c.txt.bz", "a/b/c.nc"];
out = stdlib.with_suffix(in, new);
tc.verifyEqual(out, exp)
end
end

end
