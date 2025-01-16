classdef TestMex < matlab.unittest.TestCase

methods (Test)

function test_is_char_device(tc)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))
% matlab exist() doesn't work for MEX detection with ".." leading path

tc.assumeEqual(exist("+stdlib/is_char_device", "file"), 3)

% /dev/stdin may not be available on CI systems
if ispc
  n = "NUL";
else
  n = "/dev/null";
end

tc.verifyTrue(stdlib.is_char_device(n))
end


function test_is_admin(tc)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))

tc.assumeEqual(exist("+stdlib/is_admin", "file"), 3)
tc.verifyClass(stdlib.is_admin(), "logical")
end

end

end
