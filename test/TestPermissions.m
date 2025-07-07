classdef TestPermissions < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", pwd()}
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

tf = tc.createTemporaryFolder();

nr = fullfile(tf, "no-read");

tc.verifyTrue(stdlib.touch(nr))
stdlib.set_permissions(nr, -1, 0, 0)
p = stdlib.get_permissions(nr);

if ~ispc
tc.verifyThat(p, StartsWithSubstring("-"), "no-read permission failed to set")
end

nw = fullfile(tf, "no-write");

tc.verifyTrue(stdlib.touch(nw))
stdlib.set_permissions(nw, 0, -1, 0)
p = stdlib.get_permissions(nw);

if ~ispc
tc.verifyThat(p, StartsWithSubstring("r-"), "no-write permission failed to set")
end

end

end

end
