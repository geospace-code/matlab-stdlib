classdef TestFileImpure < matlab.unittest.TestCase

methods (Test)

function test_expanduser(tc)
import matlab.unittest.constraints.EndsWithSubstring
import stdlib.expanduser
tc.assumeTrue(usejava("jvm"), "Java required")

tc.verifyEmpty(expanduser(string.empty))
tc.verifyEqual(expanduser(""), "")

tc.verifyEqual(expanduser("~abc"), "~abc")

tc.verifyFalse(startsWith(expanduser('~/foo'), "~"))

tc.verifyThat(expanduser('~/foo'), EndsWithSubstring("foo"))
end


function test_makedir(tc)
d = tempname;
stdlib.makedir(d)
tc.assertTrue(isfolder(d))
end


function test_samepath(tc)

tc.verifyEmpty(stdlib.samepath(string.empty, string.empty))
tc.verifyTrue(stdlib.samepath("", ""))
tc.verifyFalse(stdlib.samepath(tempname, tempname))
tc.verifyTrue(stdlib.samepath("~/b/..", "~/c/.."), "tilde path ..")
tc.verifyTrue(stdlib.samepath(".", fullfile(pwd, "a/..")))
end


function test_which_name(tc)
tc.assumeTrue(usejava("jvm"), "Java required")

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
import matlab.unittest.constraints.EndsWithSubstring
tc.assumeTrue(usejava("jvm"), "Java required")

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
  tc.verifyThat(exe, EndsWithSubstring(".exe"))
else
  tc.verifyThat(exe, ~EndsWithSubstring(".exe"))
end
tc.verifyThat(exe, IsFile)

end

function test_hash(tc)
import matlab.unittest.constraints.IsFile
import matlab.unittest.fixtures.TemporaryFolderFixture
tc.assumeTrue(usejava("jvm"), "Java required")

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
