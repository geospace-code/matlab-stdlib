classdef TestVersion < matlab.unittest.TestCase

methods (Test)

function test_version(tc)
tc.verifyTrue(stdlib.version_atleast("3.19.0.33", "3.19.0"))
tc.verifyFalse(stdlib.version_atleast("3.19.0.33", "3.19.0.34"))
end

end

end
