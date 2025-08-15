classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'R2019b', 'impure'}) ...
    TestWhich < matlab.unittest.TestCase

properties (TestParameter)
mexe = {matlabroot + "/bin/matlab", ...
        fullfile(matlabroot, 'bin/matlab')}
end


methods (Test)

function test_which_name(tc)

tc.verifyEmpty(stdlib.which(tempname()))

if ispc
  names = ["pwsh", "pwsh.exe"];
else
  names = "ls";
end
%% which: Matlab in environment variable PATH
% MacOS Matlab does not source .zshrc so Matlab is not on internal Matlab PATH
% Unix-like OS may have Matlab as alias which is not visible to
% stdlib.which()
% virus scanners may block stdlib.which("cmd.exe") on Windows
for n = names
  exe = stdlib.which(n);
  tc.verifyNotEmpty(exe, "Executable not found: " + n)
  tc.verifyThat(exe, matlab.unittest.constraints.IsFile, "Executable is not a file: " + n)
  tc.verifyTrue(stdlib.is_exe(exe), "Executable is not executable: " + n)
end

end


function test_which_absolute(tc, mexe)

r = string(mexe);
if ispc()
  r = r + ".exe";
end

tc.assumeThat(r, matlab.unittest.constraints.IsFile)
tc.assumeTrue(stdlib.is_exe(r))

tc.verifyGreaterThan(strlength(stdlib.which(r)), 0, "Expected which(" + r + " ) to find " + r)
tc.verifyGreaterThan(strlength(stdlib.which(mexe)), 0, "Expected which(" + mexe + ") to find " + r)

end


function test_which_onepath(tc)

tc.verifyNotEmpty(stdlib.which("matlab", fullfile(matlabroot, 'bin')), ...
    "Matlab not found by which() given specific path=")

end


function test_which_multipath(tc)

paths = split(string(getenv('PATH')), pathsep);
paths(end+1) = fullfile(matlabroot, 'bin');

tc.verifyNotEmpty(stdlib.which("matlab", paths), "Matlab not found by which()")

end

end

end
