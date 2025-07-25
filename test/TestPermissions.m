classdef TestPermissions < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", pwd(), "", tempname(), mfilename('fullpath') + ".m"}
end


methods (Test, TestTags="impure")

function test_get_permissions(tc, Ps)
import matlab.unittest.constraints.StartsWithSubstring

p = stdlib.get_permissions(Ps);

tc.verifyClass(p, "char")

if stdlib.exists(Ps)
  tc.verifyThat(p, StartsWithSubstring("r"))
  if isfile(p) && stdlib.suffix(p) == ".m"
    tc.verifyEqual(p(3), '-')
  end
else
  tc.verifyEmpty(p)
end

end


function test_set_permissions(tc)
import matlab.unittest.constraints.StartsWithSubstring

tc.assumeTrue(~isMATLABReleaseOlderThan('R2025a') || stdlib.is_mex_fun('stdlib.set_permissions'))

td = tc.createTemporaryFolder();

nr = fullfile(td, "no-read");

tc.verifyTrue(stdlib.touch(nr))
tc.verifyTrue(stdlib.set_permissions(nr, -1, 0, 0))
p = stdlib.get_permissions(nr);

if ~ispc
tc.verifyThat(p, StartsWithSubstring("-"), "no-read permission failed to set")
end

nw = fullfile(td, "no-write");

tc.verifyTrue(stdlib.touch(nw))
tc.verifyTrue(stdlib.set_permissions(nw, 0, -1, 0))
p = stdlib.get_permissions(nw);

if ~ispc
tc.verifyThat(p, StartsWithSubstring("r-"), "no-write permission failed to set")
end

end

end

end
