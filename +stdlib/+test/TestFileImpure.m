classdef TestFileImpure < matlab.unittest.TestCase

methods (Test)

function test_expanduser(tc)
import stdlib.expanduser

tc.verifyEmpty(expanduser(string.empty))
tc.verifyEqual(expanduser(""), "")

tc.verifyFalse(startsWith(expanduser('~/foo'), "~"))

tc.verifyTrue(endsWith(expanduser('~/foo'), "foo"))
end


function test_makedir(tc)
d = tempname;
stdlib.makedir(d)
tc.assertTrue(isfolder(d))
end


function test_samepath(tc)
import stdlib.fileio.samepath
tc.assumeTrue(usejava("jvm"), "Java required for samepath")

tc.verifyEmpty(samepath(string.empty, string.empty))
tc.verifyTrue(samepath("", ""))
tc.verifyFalse(samepath(tempname, tempname))
tc.verifyTrue(samepath("~/b/..", "~/c/.."), "tilde path ..")
tc.verifyTrue(samepath(".", "a/.."))
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
import matlab.unittest.fixtures.TemporaryFolderFixture

fixture = tc.applyFixture(TemporaryFolderFixture);

fn = fullfile(fixture.Folder, "hello");
fid = fopen(fn, "w");
tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");
fclose(fid);
tc.assumeThat(fn, IsFile)

tc.verifyEqual(stdlib.fileio.file_checksum(fn, "md5"), "5d41402abc4b2a76b9719d911017c592")
tc.verifyEqual(stdlib.fileio.file_checksum(fn, "sha256"), "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824")

end

end

end
