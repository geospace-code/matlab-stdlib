classdef TestWSL < matlab.unittest.TestCase

methods (Test)

function test_is_exe_which_wsl(tc)

tc.assumeTrue(ispc, "Windows only")
tc.assumeTrue(stdlib.sys.has_wsl(), "did not find Windows Subsystem for Linux")

[ret, cc] = system("wsl which cc");
tc.assumeEqual(ret, 0, "could not find WSL C compiler")
tc.assumeNotEmpty(cc, "did not find WSL C compiler")

cwd = fileparts(mfilename('fullpath'));
src = stdlib.sys.winpath2wslpath(fullfile(cwd, "main.c"));

[ret, out_wsl] = system("wsl mktemp -u");
tc.assumeEqual(ret, 0, "could not get WSL tempfile")
out_wsl = strtrim(out_wsl);

ret = system("wsl cc " + src + " -o" + out_wsl);

tc.assumeEqual(ret, 0, "failed to compile " + src)
out = stdlib.sys.wslpath2winpath(out_wsl);
tc.assumeTrue(isfile(out), "cc failed to produce output file " + out)

tc.verifyTrue(stdlib.fileio.is_exe(out), "is_exe() failed to detect WSL executable " + out)

wsl_exe = stdlib.fileio.which(out);
tc.verifyNotEmpty(wsl_exe, "which() failed to detect WSL executable " + out)

end


function test_wsl_path(tc)

tc.assumeTrue(ispc, "Windows only")
tc.assumeTrue(stdlib.sys.has_wsl(), "did not find Windows Subsystem for Linux")

wsl_temp = stdlib.sys.wsl_tempfile();
tc.verifyNotEmpty(wsl_temp, "could not get WSL tempfile")

wsl_path = stdlib.sys.wslpath2winpath(wsl_temp);
tc.verifyTrue(stdlib.fileio.is_wsl_path(wsl_path), "could not convert WSL path to Windows path")

win_path = stdlib.sys.winpath2wslpath(wsl_path);
tc.verifyNotEmpty(win_path, "could not convert Windows path to WSL path")

end

end

end
