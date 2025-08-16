classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'impure'}) ...
    TestPermissions < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", pwd(), "", tempname(), mfilename('fullpath') + ".m"}
B_get_permissions
B_set_permissions
end


methods (TestParameterDefinition, Static)
function [B_get_permissions, B_set_permissions] = setupBackends()
B_get_permissions = init_backend('get_permissions');
B_set_permissions = init_backend('set_permissions');
end
end


methods(TestMethodSetup)
function w_dirs(tc)
  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test, TestTags={'R2021a'})

function test_get_permissions(tc, Ps, B_get_permissions)
import matlab.unittest.constraints.StartsWithSubstring

p = stdlib.get_permissions(Ps, B_get_permissions);
tc.verifyClass(p, "char")
if ~stdlib.exists(Ps)
  tc.verifyEmpty(p)
else
  tc.verifyThat(p, StartsWithSubstring("r"))
  if isfile(p) && stdlib.suffix(p) == ".m"
    tc.verifyEqual(p(3), '-')
  end
end
end


function test_get_permissions_exe(tc, B_get_permissions)
matlab_exe = fullfile(matlabroot, "bin/matlab");
if ispc()
  matlab_exe = matlab_exe + ".exe";
end

tc.assertThat(matlab_exe, matlab.unittest.constraints.IsFile)
p = stdlib.get_permissions(matlab_exe, B_get_permissions);

tc.assertNotEmpty(p)
tc.verifyEqual(p(3), 'x')

end


function test_set_permissions_nowrite(tc, B_set_permissions)
import matlab.unittest.constraints.StartsWithSubstring

nw = fullfile(pwd(), "no-write");

tc.assertTrue(stdlib.touch(nw))
r = stdlib.set_permissions(nw, 0, -1, 0, B_set_permissions);

tc.assertTrue(r)

p = stdlib.get_permissions(nw);
if ~ispc() || B_set_permissions ~= "legacy"
tc.verifyThat(p, StartsWithSubstring("r-"), "no-write permission failed to set")
end

end

end


methods (Test, TestTags={'R2025a'})

function test_set_permissions_noread(tc)
import matlab.unittest.constraints.StartsWithSubstring

% This ONLY works with the new setPermissions.
% fileattrib can not even set the permissions on Linux.
tc.assumeFalse(stdlib.matlabOlderThan('R2025a'))

nr = fullfile(pwd(), "no-read");

tc.assertTrue(stdlib.touch(nr))
tc.assertTrue(stdlib.set_permissions(nr, -1, 0, 0, 'native'))
p = stdlib.get_permissions(nr);

if ~ispc()
  tc.verifyThat(p, StartsWithSubstring("-"), "no-read permission failed to set")
end
end

end

end
