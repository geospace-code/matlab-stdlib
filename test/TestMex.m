classdef TestMex < matlab.unittest.TestCase

methods (Test)

function test_is_char_device(tc)
% /dev/stdin may not be available on CI systems

if ispc
  n = "NUL";
else
  n = "/dev/null";
end

tc.verifyTrue(stdlib.is_char_device(n))

end

end

end
