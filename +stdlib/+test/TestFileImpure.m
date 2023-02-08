classdef TestFileImpure < matlab.unittest.TestCase

methods (Test)

function test_expanduser(tc)
import stdlib.expanduser

tc.verifyEmpty(expanduser(string.empty))
tc.verifyEqual(expanduser(""), "")

tc.verifyFalse(startsWith(expanduser('~/foo'), "~"))
tc.verifyFalse(any(startsWith(expanduser(["~/abc", "~/123"]), "~")))

tc.verifyTrue(endsWith(expanduser('~/foo'), "foo"))
tc.verifyTrue(all(endsWith(expanduser(["~/abc", "~/123"]), ["abc", "123"])))
end

function test_makedir(tc)
d = tempname;
stdlib.makedir(d)
tc.assertTrue(isfolder(d))
end

function test_which_name(tc)

tc.verifyEmpty(stdlib.which(tempname))

if ismac
  n = "ls";
else
  n = "matlab";
end
%% which: Matlab in environment variable PATH
% MacOS Matlab does not source .zshrc so Matlab is not on internal Matlab PATH
tc.verifyNotEmpty(stdlib.which(n))

end


function test_is_exe_which_fullpath(tc)
import matlab.unittest.constraints.IsFile

tc.verifyEmpty(stdlib.is_exe(string.empty))
tc.verifyFalse(stdlib.is_exe(""))
tc.verifyFalse(stdlib.is_exe(tempname))

n = "matlab";
%% is_exe test
p = fullfile(matlabroot, "bin", n);
if ispc
  fp = p + ".exe";
else
  fp = p;
end
tc.verifyTrue(stdlib.is_exe(fp))
%% which: test absolute path
exe = stdlib.which(p);

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
