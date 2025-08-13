classdef TestPermissions < matlab.unittest.TestCase



properties (TestParameter)
Ps = {".", pwd(), "", tempname(), mfilename('fullpath') + ".m"}
fname = {'native', 'legacy'}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end


methods (Test, TestTags=["R2019b", "impure"])

function test_get_permissions(tc, Ps, fname)
import matlab.unittest.constraints.StartsWithSubstring

try
  p = stdlib.get_permissions(Ps, fname);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end
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


function test_set_permissions_nowrite(tc, fname)
import matlab.unittest.constraints.StartsWithSubstring
td = createTempdir(tc);

nw = fullfile(td, "no-write");

tc.verifyTrue(stdlib.touch(nw))
try
  tc.verifyTrue(stdlib.set_permissions(nw, 0, -1, 0, fname))
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

p = stdlib.get_permissions(nw);
if ~ispc() || fname ~= "legacy"
  tc.verifyThat(p, StartsWithSubstring("r-"), "no-write permission failed to set")
end
end

end


methods (Test, TestTags=["R2025a", "impure"])

function test_set_permissions_noread(tc)
import matlab.unittest.constraints.StartsWithSubstring

% This ONLY works with the new setPermissions.
% fileattrib can not even set the permissions on Linux.
tc.assumeFalse(stdlib.matlabOlderThan('R2025a'))
td = tc.createTemporaryFolder();

nr = fullfile(td, "no-read");

tc.verifyTrue(stdlib.touch(nr))
tc.verifyTrue(stdlib.set_permissions(nr, -1, 0, 0, "native"))
p = stdlib.get_permissions(nr);

if ~ispc()
  tc.verifyThat(p, StartsWithSubstring("-"), "no-read permission failed to set")
end
end

end

end
