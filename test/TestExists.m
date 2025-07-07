classdef TestExists < matlab.unittest.TestCase

properties(TestParameter)
Ps = {{pwd(), true}, {mfilename("fullpath") + ".m", true}, ...
      {"TestFileImpure.m", true}}
% on CI matlabroot can be writable!
end

methods (Test, TestTags="impure")

function test_exists(tc, Ps)
ok = stdlib.exists(Ps{1});
tc.verifyEqual(ok, Ps{2})
end


function test_is_readable(tc, Ps)
ok = stdlib.is_readable(Ps{1});
tc.verifyEqual(ok, Ps{2})
end


end

end
