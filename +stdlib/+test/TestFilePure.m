classdef TestFilePure < matlab.unittest.TestCase

methods (Test)

function test_posix(tc)
import stdlib.posix

tc.verifyEmpty(posix(string.empty))
tc.verifyEqual(posix(""), "")

if ispc
  tc.verifyFalse(contains(posix("c:\foo"), "\"))
  tc.verifyFalse(all(contains(posix(["x:\123", "d:\abc"]), "\")))
end
end

function test_samepath(tc)

import stdlib.samepath

tc.assumeTrue(usejava("jvm"), "Java required for samepath")

tc.verifyEmpty(samepath(string.empty, string.empty))
tc.verifyTrue(samepath("", ""))
tc.verifyFalse(samepath("a", "b"))
tc.verifyTrue(samepath("a/b/..", "a/c/.."))
tc.verifyTrue(samepath(".", "a/.."))

end

function test_path_tail(tc)

import stdlib.path_tail

tc.assumeTrue(usejava("jvm"), "Java required for path_tail")

tc.verifyEmpty(path_tail(string.empty))
tc.verifyEqual(path_tail(""), "")
tc.verifyEqual(path_tail("/foo/bar/baz"), "baz")
tc.verifyEqual(path_tail("/foo/bar/baz/"), "baz")
tc.verifyEqual(path_tail("/foo/bar/baz/."), "baz")
tc.verifyEqual(path_tail("/foo/bar/baz/.."), "bar")
tc.verifyEqual(path_tail("/foo/bar/baz.txt"), "baz.txt")

end

function test_is_absolute_path(tc)

import stdlib.is_absolute_path
% path need not exist

tc.verifyEmpty(is_absolute_path(string.empty))
tc.verifyFalse(is_absolute_path(""))

tc.verifyTrue(is_absolute_path('~/foo'))
if ispc
  tc.verifyTrue(is_absolute_path('x:/foo'))
  tc.verifyFalse(is_absolute_path('/foo'))
else
  tc.verifyTrue(is_absolute_path('/foo'))
end

tc.verifyFalse(is_absolute_path("c"))
end

function test_canonical(tc)

import stdlib.canonical

tc.assumeTrue(usejava("jvm"), "Java required for canonical")

tc.verifyEmpty(canonical(string.empty))
tc.verifyEqual(canonical(""), string(pwd))

pabs = canonical('2foo');
pabs2 = canonical('4foo');
tc.verifyFalse(startsWith(pabs, "2"))
tc.verifyTrue(strncmp(pabs, pabs2, 2))

par1 = canonical("../2foo");
tc.verifyNotEmpty(par1)
tc.verifyFalse(contains(par1, ".."))

par2 = canonical("../4foo");
tc.verifyTrue(strncmp(par2, pabs2, 2))

pt1 = canonical("bar/../2foo");
tc.verifyNotEmpty(pt1)
tc.verifyFalse(contains(pt1, ".."))

va = canonical("2foo");
vb = canonical("4foo");
tc.verifyFalse(startsWith(va, "2"))
tc.verifyTrue(strncmp(va, vb, 2))

end

function test_with_suffix(tc)
import stdlib.with_suffix

tc.verifyEmpty(with_suffix(string.empty, ".nc"))
tc.verifyEqual(with_suffix("", ""), "")

tc.verifyEqual(with_suffix("foo.h5", ".nc"), "foo.nc")
tc.verifyEqual(with_suffix(["foo.h5", "bar.dat"], ".nc"), ["foo.nc", "bar.nc"])

tc.verifyEqual(with_suffix("c", ""), "c")
tc.verifyEqual(with_suffix("c.nc", ""), "c")
tc.verifyEqual(with_suffix("", ".nc"), ".nc")
end

end
end
