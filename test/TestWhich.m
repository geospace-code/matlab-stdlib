classdef TestWhich < matlab.unittest.TestCase

properties (TestParameter)
mexe = {matlabroot + "/bin/" + matlab_name(), ...
        fullfile(matlabroot, 'bin', matlab_name())}
end

methods (Test, TestTags="impure")

function test_which_name(tc)

tc.verifyEmpty(stdlib.which(tempname()))

if ispc
  n = 'pwsh.exe';
else
  n = 'ls';
end
%% which: Matlab in environment variable PATH
% MacOS Matlab does not source .zshrc so Matlab is not on internal Matlab PATH
% Unix-like OS may have Matlab as alias which is not visible to
% stdlib.which()
% virus scanners may block stdlib.which("cmd.exe") on Windows
tc.verifyNotEmpty(stdlib.which(n))

end


function test_which_absolute(tc, mexe)
tc.verifyEqual(stdlib.which(mexe), mexe)
end


function test_which_multipath(tc)

n = matlab_name();

paths = split(string(getenv('PATH')), pathsep);
paths(end+1) = matlabroot + "/bin";

exe = stdlib.which(n, paths);

tc.verifyNotEmpty(exe, "Matlab not found by which()")

end

end

end


function n = matlab_name()

n = 'matlab';
if ispc
  n = strcat(n, '.exe');
end
end
