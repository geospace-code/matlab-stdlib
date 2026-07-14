classdef TestPermissions < StdlibPath

properties
file = 'perm.txt'
end

properties (TestParameter)
Ps = {'.', pwd(), 'perm.txt'}
Pe = {'', tempname()}
end


methods(TestClassSetup)
function w_dirs(tc)
  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
  tc.assertTrue(stdlib.touch(tc.file))
end
end


methods (Test)

function test_not_exist(tc, Pe)
e = 'MATLAB:validators:mustBeFileOrFolder';
tc.verifyError(@() stdlib.get_permissions(Pe), e)

tc.verifyError(@() stdlib.set_permissions(Pe), e)
end

function test_get_permissions(tc, Ps)
import matlab.unittest.constraints.StartsWithSubstring

p = stdlib.get_permissions(Ps);
tc.verifyClass(p, 'char')

tc.verifyThat(p, StartsWithSubstring('r'))
if ~ispc() && strcmp(Ps, tc.file)
  tc.verifyEqual(p(3), '-')
end
end


function test_get_permissions_exe(tc)
matlab_exe = [matlabroot, '/bin/matlab'];
if ispc()
  matlab_exe = [matlab_exe, '.exe'];
end

p = stdlib.get_permissions(matlab_exe);

tc.assertNotEmpty(p)
tc.verifyEqual(p(3), 'x')
end

end


methods (Test, TestTags={'R2025a'})

function test_set_permissions_nowrite(tc)
import matlab.unittest.constraints.StartsWithSubstring

tc.assumeFalse(isMATLABReleaseOlderThan('R2025a'), "set_permissions requires Matlab >= R2025a")

nw = [pwd(), '/no-write'];

tc.assertTrue(stdlib.touch(nw))
r = stdlib.set_permissions(nw, [], false, []);

tc.assertTrue(r)

p = stdlib.get_permissions(nw);

if ~ispc()
  tc.verifyThat(p, StartsWithSubstring('r-'), 'no-write permission failed to set')
end
end

function test_set_permissions_noread(tc)
import matlab.unittest.constraints.StartsWithSubstring

% This ONLY works with the new setPermissions.
% fileattrib can not even set the permissions on Linux.
tc.assumeFalse(isMATLABReleaseOlderThan('R2025a'), "set_permissions no-read requires Matlab >= R2025a")

nr = [pwd(), '/no-read'];

tc.assertTrue(stdlib.touch(nr))
tc.assertTrue(stdlib.set_permissions(nr, false))
p = stdlib.get_permissions(nr);

if ~ispc()
  tc.verifyThat(p, StartsWithSubstring('-'), 'no-read permission failed to set')
end
end

end

end
