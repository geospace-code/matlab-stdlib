classdef TestWithSuffix < matlab.unittest.TestCase

properties (TestParameter)
p = {{"foo.h5", ".nc", "foo\.nc"},...
{"c", "", "c"}, ...
{"c.nc", "", "c"}, ...
{"", ".nc", "\.nc"}, ...
{"a/b/c/", ".h5", "a/b/c/\.h5"}, ...
{"a/b/.h5", ".nc", "a/b/\.h5\.nc"}, ...
{'a/b', '.nc', 'a/b\.nc'}};
end

methods (Test)
function test_with_suffix(tc, p)
import matlab.unittest.constraints.Matches
tc.verifyThat(stdlib.with_suffix(p{1}, p{2}), Matches(p{3}))
end
end

end
