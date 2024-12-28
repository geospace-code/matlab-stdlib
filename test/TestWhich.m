classdef TestWhich < matlab.unittest.TestCase

properties (TestParameter)
use_java = num2cell(unique([stdlib.has_java(), false]))
end


methods (Test)

function test_which_name(tc, use_java)

tc.verifyEmpty(stdlib.which(tempname, getenv('PATH'), use_java))

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
tc.verifyNotEmpty(stdlib.which(n, getenv('PATH'), use_java))

end


function test_is_exe_which_fullpath(tc, use_java)
import matlab.unittest.constraints.IsFile
import matlab.unittest.constraints.EndsWithSubstring

tc.verifyFalse(stdlib.is_exe("", use_java))
tc.verifyFalse(stdlib.is_exe(tempname, use_java))

n = "matlab";
%% is_exe test
p = fullfile(matlabroot, "bin", n);
if ispc
  fp = p + ".exe";
else
  fp = p;
end
tc.verifyTrue(stdlib.is_exe(fp, use_java))
%% which: test absolute path
exe = stdlib.which(p, getenv('PATH'), use_java);

if ispc
  tc.verifyThat(exe, EndsWithSubstring(".exe"))
else
  tc.verifyThat(exe, ~EndsWithSubstring(".exe"))
end
tc.verifyThat(exe, IsFile)

end

end

end
