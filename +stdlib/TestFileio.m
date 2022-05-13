classdef TestFileio < matlab.unittest.TestCase

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

function test_posix(tc)
import stdlib.fileio.posix

if ispc
  tc.verifyFalse(contains(posix("c:\foo"), "\"))
  tc.verifyFalse(any(contains(posix(["x:\123", "d:\abc"]), "\")))
end

tc.verifyEmpty(posix(string.empty))
end

function test_path_tail(tc)

import stdlib.fileio.path_tail

tc.verifyEqual(path_tail("/foo/bar/baz"), "baz")
tc.verifyEqual(path_tail("/foo/bar/baz/"), "baz")
tc.verifyEqual(path_tail("/foo/bar/baz/."), "baz")
tc.verifyEqual(path_tail("/foo/bar/baz/.."), "bar")
tc.verifyEqual(path_tail("/foo/bar/baz.txt"), "baz.txt")

end

function test_is_absolute_path(tc)

import stdlib.fileio.is_absolute_path
% path need not exist
tc.verifyTrue(is_absolute_path('~/foo'))
if ispc
  tc.verifyTrue(is_absolute_path('x:/foo'))
  tc.verifyEqual(is_absolute_path(["x:/abc", "x:/123", "", "c"]), [true, true, false, false])
  tc.verifyTrue(all(is_absolute_path(["x:/abc"; "x:/123"])))
  tc.verifyFalse(is_absolute_path('/foo'))
else
  tc.verifyTrue(is_absolute_path('/foo'))
end

tc.verifyEmpty(is_absolute_path(string.empty))
tc.verifyFalse(is_absolute_path(""))
tc.verifyFalse(is_absolute_path("c"))
end

function test_absolute_path(tc)

import stdlib.fileio.absolute_path

pabs = absolute_path('2foo');
pabs2 = absolute_path('4foo');
tc.verifyFalse(startsWith(pabs, "2"))
tc.verifyTrue(strncmp(pabs, pabs2, 2))

par1 = absolute_path("../2foo");
par2 = absolute_path("../4foo");
tc.verifyFalse(startsWith(par1, ".."))
tc.verifyTrue(strncmp(par2, pabs2, 2))

pt1 = absolute_path("bar/../2foo");
tc.verifyFalse(contains(pt1, ".."))

va = absolute_path(["2foo", "4foo"]);
tc.verifyFalse(any(startsWith(va, "2")))
vs = extractBefore(va, 2);
tc.verifyEqual(vs(1), vs(2))

tc.verifyEmpty(absolute_path(string.empty))
tc.verifyEqual(absolute_path(""), string(pwd))
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

function test_with_suffix(tc)
import stdlib.fileio.with_suffix
tc.verifyEqual(with_suffix("foo.h5", ".nc"), "foo.nc")
if ~verLessThan("matlab", "9.9")
% fileparts vectorized in R2020b
tc.verifyEqual(with_suffix(["foo.h5", "bar.dat"], ".nc"), ["foo.nc", "bar.nc"])

tc.verifyEmpty(with_suffix(string.empty, ".nc"))
tc.verifyEqual(with_suffix("", ""), "")
tc.verifyEqual(with_suffix("c", ""), "c")
tc.verifyEqual(with_suffix("c.nc", ""), "c")
tc.verifyEqual(with_suffix("", ".nc"), ".nc")
end
end

function test_copyfile(tc)
import matlab.unittest.constraints.IsFile

f1 = tempname;
[~,name] = fileparts(f1);
fclose(fopen(f1,'w'));
stdlib.fileio.copyfile(f1, tempdir)

tc.verifyThat(fullfile(tempdir, name), IsFile)
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
