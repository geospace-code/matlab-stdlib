classdef TestPermissions < matlab.unittest.TestCase

properties
td
end


properties (TestParameter)
Ps = {".", pwd()}
end


methods(TestClassSetup)
function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
end
end

methods(TestClassTeardown)
function remove_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  [s, m, i] = rmdir(tc.td, 's');
  if ~s, warning(i, "Failed to remove temporary directory %s: %s", tc.td, m); end
end
end
end


methods (Test, TestTags="impure")

function test_get_permissions(tc, Ps)
import matlab.unittest.constraints.StartsWithSubstring

p = stdlib.get_permissions(Ps);

tc.verifyThat(p, StartsWithSubstring("r"))
tc.verifyClass(p, "char")

end

end



methods(Test, TestTags = "mex")

function test_set_permissions(tc)

import matlab.unittest.constraints.StartsWithSubstring

nr = fullfile(tc.td, "no-read");

tc.verifyTrue(stdlib.touch(nr))
stdlib.set_permissions(nr, -1, 0, 0)
p = stdlib.get_permissions(nr);

if ~ispc
tc.verifyThat(p, StartsWithSubstring("-"), "no-read permission failed to set")
end

nw = fullfile(tc.td, "no-write");

tc.verifyTrue(stdlib.touch(nw))
stdlib.set_permissions(nw, 0, -1, 0)
p = stdlib.get_permissions(nw);

if ~ispc
tc.verifyThat(p, StartsWithSubstring("r-"), "no-write permission failed to set")
end

end

end

end
