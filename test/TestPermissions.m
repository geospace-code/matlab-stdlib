classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'impure'}) ...
    TestPermissions < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", pwd(), "", tempname(), mfilename('fullpath') + ".m"}
end


methods(TestMethodSetup)
function w_dirs(tc)
  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test, TestTags={'R2021a'})

function test_get_permissions(tc, Ps)
import matlab.unittest.constraints.StartsWithSubstring

[p, b] = stdlib.get_permissions(Ps);

tc.verifyClass(p, "char")

if ~stdlib.exists(Ps)
  tc.verifyEmpty(p)
else
  if isMATLABReleaseOlderThan('R2025a')
    tc.assertEqual(b, 'legacy')
  else
    tc.assertEqual(b, 'native')
  end

  tc.verifyThat(p, StartsWithSubstring("r"))
  if isfile(p) && stdlib.suffix(p) == ".m"
    tc.verifyEqual(p(3), '-')
  end
end
end


function test_get_permissions_exe(tc)
matlab_exe = fullfile(matlabroot, "bin/matlab");
if ispc()
  matlab_exe = matlab_exe + ".exe";
end

tc.assertThat(matlab_exe, matlab.unittest.constraints.IsFile)
p = stdlib.get_permissions(matlab_exe);

tc.assertNotEmpty(p)
tc.verifyEqual(p(3), 'x')

end


function test_set_permissions_nowrite(tc)
import matlab.unittest.constraints.StartsWithSubstring

nw = fullfile(pwd(), "no-write");

tc.assertTrue(stdlib.touch(nw))
r = stdlib.set_permissions(nw, 0, -1, 0);

tc.assertTrue(r)

[p, b] = stdlib.get_permissions(nw);

if isMATLABReleaseOlderThan('R2025a')
  tc.assertEqual(b, 'legacy')
else
  tc.assertEqual(b, 'native')
end

if ~ispc() || b ~= "legacy"
  tc.verifyThat(p, StartsWithSubstring("r-"), "no-write permission failed to set")
end

end

end


methods (Test, TestTags={'R2025a'})

function test_set_permissions_noread(tc)
import matlab.unittest.constraints.StartsWithSubstring

% This ONLY works with the new setPermissions.
% fileattrib can not even set the permissions on Linux.
tc.assumeFalse(isMATLABReleaseOlderThan('R2025a'))

nr = fullfile(pwd(), "no-read");

tc.assertTrue(stdlib.touch(nr))
tc.assertTrue(stdlib.set_permissions(nr, -1, 0, 0))
p = stdlib.get_permissions(nr);

if ~ispc()
  tc.verifyThat(p, StartsWithSubstring("-"), "no-read permission failed to set")
end
end

end

end
