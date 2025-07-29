classdef TestPermissions < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", pwd(), "", tempname(), mfilename('fullpath') + ".m"}
sp_fun = {@stdlib.native.set_permissions, @stdlib.native.set_permissions_legacy}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
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


function test_set_permissions_noread(tc, sp_fun)
import matlab.unittest.constraints.StartsWithSubstring
is_capable(tc, sp_fun)

tc.assumeFalse((ispc() && isMATLABReleaseOlderThan('R2025a')) || isMATLABReleaseOlderThan('R2022a'))
td = tc.createTemporaryFolder();

nr = fullfile(td, "no-read");

tc.verifyTrue(stdlib.touch(nr))
tc.verifyTrue(sp_fun(nr, -1, 0, 0))
p = stdlib.get_permissions(nr);

if ~ispc() || ~endsWith(func2str(sp_fun), "legacy")
  tc.verifyThat(p, StartsWithSubstring("-"), "no-read permission failed to set")
end

end


function test_set_permissions_nowrite(tc, sp_fun)
import matlab.unittest.constraints.StartsWithSubstring
is_capable(tc, sp_fun)

tc.assumeFalse(isMATLABReleaseOlderThan('R2022a'))
td = tc.createTemporaryFolder();

nw = fullfile(td, "no-write");

tc.verifyTrue(stdlib.touch(nw))
tc.verifyTrue(sp_fun(nw, 0, -1, 0))
p = stdlib.get_permissions(nw);

if ~ispc() || ~endsWith(func2str(sp_fun), "legacy")
  tc.verifyThat(p, StartsWithSubstring("r-"), "no-write permission failed to set")
end

end

end

end
