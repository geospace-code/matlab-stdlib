classdef TestWithSuffix < matlab.unittest.TestCase

properties
is_mex = stdlib.is_mex_fun("stdlib.with_suffix")
end

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

methods (Test, TestTags="true")
function test_with_suffix(tc, p)

if tc.is_mex
  r = string(p{3});
else
  r = p{3};
end

tc.verifyEqual(stdlib.with_suffix(p{1}, p{2}), r, ...
    sprintf("mex: %d", tc.is_mex))
end
end

end
