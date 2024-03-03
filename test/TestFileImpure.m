classdef TestFileImpure < matlab.unittest.TestCase

methods(TestClassSetup)

function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))

end

end

methods (Test)

function test_exists(tc)

tc.verifyTrue(stdlib.exists(pwd))
tc.verifyTrue(stdlib.exists(string(mfilename("fullpath"))+".m"))
tc.verifyFalse(stdlib.exists("not-exists"))

end


function test_is_readable(tc)

tc.verifyTrue(stdlib.is_readable(pwd))
tc.verifyTrue(stdlib.is_readable(string(mfilename("fullpath"))+".m"))
tc.verifyFalse(stdlib.is_readable("not-exists"))

end


function test_is_writable(tc)

tc.verifyTrue(stdlib.is_writable(pwd))
% tc.verifyFalse(stdlib.is_writable(matlabroot))  % on CI this can be writable!
tc.verifyFalse(stdlib.is_writable("not-exists"))

end



function test_expanduser(tc)

tc.verifyEqual(stdlib.expanduser(""), "")

tc.verifyEqual(stdlib.expanduser("~abc"), "~abc")

h = stdlib.fileio.homedir();
tc.verifyEqual(stdlib.expanduser("~"), h)

e = stdlib.expanduser("~/foo");
tc.verifyEqual(e, stdlib.fileio.join(h, "foo"))

end


function test_absolute_path(tc)
import matlab.unittest.constraints.StartsWithSubstring

tc.verifyEqual(stdlib.absolute_path(""), "")

pabs = stdlib.absolute_path('2foo');
pabs2 = stdlib.absolute_path('4foo');
tc.verifyThat(pabs, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(pabs, pabs2, 2))

par1 = stdlib.absolute_path("../2foo");
tc.verifyNotEmpty(par1)

par2 = stdlib.absolute_path("../4foo");
tc.verifyTrue(strncmp(par2, pabs2, 2))

pt1 = stdlib.absolute_path("bar/../2foo");
tc.verifyNotEmpty(pt1)

va = stdlib.absolute_path("2foo");
vb = stdlib.absolute_path("4foo");
tc.verifyThat(va, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(va, vb, 2))

end


function test_canonical(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.constraints.StartsWithSubstring

td = tc.applyFixture(TemporaryFolderFixture).Folder;
tc.applyFixture(CurrentFolderFixture(td))

% all non-existing files

tc.verifyEqual(stdlib.canonical(""), "")

pabs = stdlib.canonical('2foo');
tc.verifyThat(pabs, StartsWithSubstring("2foo"))

par1 = stdlib.canonical("../2foo");
tc.verifyNotEmpty(par1)
tc.verifyThat(par1, StartsWithSubstring(".."))

pt1 = stdlib.canonical("bar/../2foo");
tc.verifyEqual(pt1, "2foo")

% test existing file
r = stdlib.parent(mfilename('fullpath'));
tc.verifyEqual(stdlib.canonical(fullfile(r, "..")), stdlib.parent(r))

h = stdlib.fileio.homedir;
tc.verifyEqual(stdlib.canonical("~"), h)
tc.verifyEqual(stdlib.canonical("~/"), h)
tc.verifyEqual(stdlib.canonical("~/.."), stdlib.parent(h))

tc.verifyEqual(stdlib.canonical("nobody.txt"), "nobody.txt")
tc.verifyEqual(stdlib.canonical("../nobody.txt"), "../nobody.txt")

end


function test_resolve(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.EndsWithSubstring
import matlab.unittest.constraints.ContainsSubstring

td = tc.applyFixture(TemporaryFolderFixture).Folder;
tc.applyFixture(CurrentFolderFixture(td))

% all non-existing files

tc.verifyEqual(stdlib.resolve(""), stdlib.fileio.posix(pwd))

pabs = stdlib.resolve('2foo');
pabs2 = stdlib.resolve('4foo');
tc.verifyThat(pabs, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(pabs, pabs2, 2))

par1 = stdlib.resolve("../2foo");
tc.verifyNotEmpty(par1)
tc.verifyThat(par1, ~ContainsSubstring(".."))

par2 = stdlib.resolve("../4foo");
tc.verifyTrue(strncmp(par2, pabs2, 2))

pt1 = stdlib.resolve("bar/../2foo");
tc.verifyNotEmpty(pt1)
tc.verifyThat(pt1, ~ContainsSubstring(".."))

va = stdlib.resolve("2foo");
vb = stdlib.resolve("4foo");
tc.verifyThat(va, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(va, vb, 2))

% test existing file
r = stdlib.parent(mfilename('fullpath'));
rp = stdlib.parent(r);
tc.verifyEqual(stdlib.resolve(rp), stdlib.parent(r))

h = stdlib.fileio.homedir;
tc.verifyEqual(stdlib.resolve("~"), h)
tc.verifyEqual(stdlib.resolve("~/"), h)
tc.verifyEqual(stdlib.resolve("~/.."), stdlib.parent(h))

tc.verifyEqual(stdlib.resolve("nobody.txt"), stdlib.join(td, "nobody.txt"))
tc.verifyEqual(stdlib.resolve("../nobody.txt"), stdlib.join(stdlib.parent(td), "nobody.txt"))

end


function test_makedir(tc)
d = tempname;
stdlib.makedir(d)
tc.assertTrue(isfolder(d))
end


function test_samepath(tc)

tc.verifyFalse(stdlib.samepath("", ""), "empty not same")
tc.verifyFalse(stdlib.samepath(tempname, tempname), "tempname not same")
tc.verifyTrue(stdlib.samepath("~/b/..", "~/c/.."), "tilde path ..")
tc.verifyTrue(stdlib.samepath(".", fullfile(pwd, "a/..")), "dot path ..")
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
import matlab.unittest.constraints.EndsWithSubstring

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

fixture = tc.applyFixture(TemporaryFolderFixture);

fn = stdlib.join(fixture.Folder, "hello");
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
