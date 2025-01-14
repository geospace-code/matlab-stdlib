classdef TestPermissions < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", tempname, "", "not-exist", "file:///"}
end

methods (Test)

function test_get_permissions(tc, Ps)
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.IsOfClass

p = stdlib.get_permissions(Ps);

if stdlib.exists(Ps)
  tc.verifyThat(p, StartsWithSubstring("r"))
  tc.verifyThat(p, IsOfClass("char"))
else
  tc.verifyEmpty(p)
end

end

end

end