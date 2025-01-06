classdef TestWhich < matlab.unittest.TestCase

methods (Test)

function test_which_name(tc)

tc.verifyEmpty(stdlib.which(tempname))

if ispc
  n = "pwsh.exe";
else
  n = "ls";
end
%% which: Matlab in environment variable PATH
% MacOS Matlab does not source .zshrc so Matlab is not on internal Matlab PATH
% Unix-like OS may have Matlab as alias which is not visible to
% stdlib.which()
% virus scanners may block stdlib.which("cmd.exe") on Windows
tc.verifyNotEmpty(stdlib.which(n))

end


function test_which_fullpath(tc)
import matlab.unittest.constraints.IsFile
import matlab.unittest.constraints.EndsWithSubstring

n = "matlab";
%% is_exe test
p = matlabroot + "/bin/" + n;
if ispc
  p = p + ".exe";
end
tc.assumeTrue(stdlib.is_exe(p), "Matlab not executable " + p)
%% which: test absolute path
exe = stdlib.which(p);

if ispc
  tc.verifyThat(exe, EndsWithSubstring(".exe"))
else
  tc.verifyThat(exe, ~EndsWithSubstring(".exe"))
end
tc.verifyThat(exe, IsFile)

end

end

end
