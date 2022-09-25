classdef TestFileImpure < matlab.unittest.TestCase

methods (Test)

function test_expanduser(tc)
import stdlib.fileio.expanduser
tc.verifyFalse(startsWith(expanduser('~/foo'), "~"))
tc.verifyFalse(any(startsWith(expanduser(["~/abc", "~/123"]), "~")))

tc.verifyTrue(endsWith(expanduser('~/foo'), "foo"))
tc.verifyTrue(all(endsWith(expanduser(["~/abc", "~/123"]), ["abc", "123"])))

tc.verifyEmpty(expanduser(string.empty))
tc.verifyEqual(expanduser(""), "")
end

function test_makedir(tc)
d = tempname;
stdlib.fileio.makedir(d)
tc.assertTrue(isfolder(d))
end

function test_which_name(tc)
import stdlib.fileio.which

if ismac
  n = "ls";
else
  n = "matlab";
end
%% which: Matlab in environment variable PATH
% MacOS Matlab does not source .zshrc so Matlab is not on internal Matlab PATH
tc.verifyNotEmpty(which(n))

end

function test_is_exe_which_wsl(tc)
import stdlib.fileio.is_exe
import stdlib.fileio.which
import stdlib.sys.subprocess_run

tc.assumeTrue(ispc, "Windows only")

wsl = which("wsl");
tc.assumeNotEmpty(wsl, "did not find Windows Subsystem for Linux")

[ret, cc] = system("wsl which cc");
tc.assumeEqual(ret, 0, "could not find WSL C compiler")
tc.assumeNotEmpty(cc, "did not find WSL C compiler")

cwd = fileparts(mfilename('fullpath'));
src = "main.c";
[~, out] = fileparts(tempname);

oldcwd = pwd;
cd(cwd)
ret = system("wsl cc " + src + " -o" + out);

tc.assumeEqual(ret, 0, "failed to compile " + src)
tc.assumeTrue(isfile(out), "cc failed to produce output file " + out)

tc.verifyTrue(is_exe(out), "is_exe() failed to detect WSL executable " + out)

wsl_exe = which(out);
tc.verifyNotEmpty(wsl_exe, "which() failed to detect WSL executable " + out)

delete(out)

cd(oldcwd)

end

function test_is_exe_which_fullpath(tc)
import matlab.unittest.constraints.IsFile
import stdlib.fileio.which
import stdlib.fileio.is_exe

n = "matlab";
%% is_exe test
p = fullfile(matlabroot, "bin", n);
if ispc
  fp = p + ".exe";
else
  fp = p;
end
tc.verifyTrue(is_exe(fp))
%% which: test absolute path
exe = which(p);

if ispc
  tc.verifyTrue(endsWith(exe, ".exe"))
else
  tc.verifyFalse(endsWith(exe, ".exe"))
end
tc.verifyThat(exe, IsFile)

end

function test_hash(tc)
import matlab.unittest.constraints.IsFile

fn = tempname;
fid = fopen(fn, "w");
tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");
fclose(fid);
tc.assumeThat(fn, IsFile)

tc.verifyEqual(stdlib.fileio.md5sum(fn), "5d41402abc4b2a76b9719d911017c592")
tc.verifyEqual(stdlib.fileio.sha256sum(fn), "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824")

delete(fn)
end

end

end
