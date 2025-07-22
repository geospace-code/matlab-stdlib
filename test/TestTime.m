classdef TestTime < matlab.unittest.TestCase

methods (Test)

function test_get_modtime(tc)
tc.verifyEmpty(stdlib.get_modtime(""))
end


end

end
