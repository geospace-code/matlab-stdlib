classdef TestFilePure < matlab.unittest.TestCase

methods (Test)

function test_posix(tc)
import stdlib.fileio.posix

if ispc
  tc.verifyFalse(contains(posix("c:\foo"), "\"))
  tc.verifyFalse(all(contains(posix(["x:\123", "d:\abc"]), "\")))
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

va = absolute_path("2foo");
vb = absolute_path("4foo");
tc.verifyFalse(startsWith(va, "2"))
tc.verifyTrue(strncmp(va, vb, 2))

tc.verifyEmpty(absolute_path(string.empty))
tc.verifyEqual(absolute_path(""), string(pwd))
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

end
end
