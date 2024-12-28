classdef TestVersion < matlab.unittest.TestCase

properties (TestParameter)
v = {{"3.19.0.33", "3.19.0", true}, {"3.19.0.33", "3.19.0.34", false}}
end


methods (Test)

function test_version(tc, v)
tc.verifyEqual(stdlib.version_atleast(v{1}, v{2}), v{3})
end

end

end
