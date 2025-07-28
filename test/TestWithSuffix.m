classdef TestWithSuffix < matlab.unittest.TestCase


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

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods (Test, TestTags="true")
function test_with_suffix(tc, p)

r = p{3};

tc.verifyEqual(stdlib.with_suffix(p{1}, p{2}), r)
end
end

end
