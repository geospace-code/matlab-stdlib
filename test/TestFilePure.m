classdef TestFilePure < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end
end


methods (Test)

function test_posix(tc)
import matlab.unittest.constraints.ContainsSubstring

tc.verifyEmpty(stdlib.posix(string.empty))
tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyThat(stdlib.posix("c:\foo"), ~ContainsSubstring("\"))
  tc.verifyThat(stdlib.posix(["x:\123", "d:\abc"]), ~ContainsSubstring("\"))
end
end


function test_filename(tc)

tc.verifyEmpty(stdlib.filename(string.empty))
tc.verifyEqual(stdlib.filename(""), "")

tc.verifyEqual(stdlib.filename("/foo/bar/baz"), "baz")
tc.verifyEqual(stdlib.filename("/foo/bar/baz/"), "")

tc.verifyEqual(stdlib.filename("foo/bar/baz.txt"), "baz.txt")
tc.verifyEqual(stdlib.filename("foo/bar/baz.txt.gz"), "baz.txt.gz")

end


function test_parent(tc)

tc.verifyEmpty(stdlib.parent(string.empty))
tc.verifyEqual(stdlib.parent(""), "")

tc.verifyEqual(stdlib.parent("/foo/bar/baz"), "/foo/bar")
tc.verifyEqual(stdlib.parent("/foo/bar/baz/"), "/foo/bar")

tc.verifyEqual(stdlib.parent("foo/bar/baz/"), "foo/bar")

end

function test_suffix(tc)

tc.verifyEmpty(stdlib.suffix(string.empty))
tc.verifyEqual(stdlib.suffix(""), "")

tc.verifyEqual(stdlib.suffix("/foo/bar/baz"), "")
tc.verifyEqual(stdlib.suffix("/foo/bar/baz/"), "")

tc.verifyEqual(stdlib.suffix("foo/bar/baz.txt"), ".txt")
tc.verifyEqual(stdlib.suffix("foo/bar/baz.txt.gz"), ".gz")

end


function test_stem(tc)

tc.verifyEmpty(stdlib.stem(string.empty))
tc.verifyEqual(stdlib.stem(""), "")

tc.verifyEqual(stdlib.stem("/foo/bar/baz"), "baz")
tc.verifyEqual(stdlib.stem("/foo/bar/baz/"), "")

tc.verifyEqual(stdlib.stem("foo/bar/baz/"), "")

tc.verifyEqual(stdlib.stem("foo/bar/baz.txt"), "baz")
tc.verifyEqual(stdlib.stem("foo/bar/baz.txt.gz"), "baz.txt")

end


function test_path_tail(tc)

tc.verifyEmpty(stdlib.path_tail(string.empty))
tc.verifyEqual(stdlib.path_tail(""), "")
tc.verifyEqual(stdlib.path_tail("/foo/bar/baz"), "baz")
tc.verifyEqual(stdlib.path_tail("/foo/bar/baz/"), "baz")
tc.verifyEqual(stdlib.path_tail("/foo/bar/baz/."), "baz")
tc.verifyEqual(stdlib.path_tail("/foo/bar/baz/.."), "bar")
tc.verifyEqual(stdlib.path_tail("/foo/bar/baz.txt"), "baz.txt")

end

function test_is_absolute_path(tc)

tc.verifyEmpty(stdlib.is_absolute_path(string.empty))
tc.verifyFalse(stdlib.is_absolute_path(""))

tc.verifyTrue(stdlib.is_absolute_path('~/foo'))
if ispc
  tc.verifyTrue(stdlib.is_absolute_path('x:/foo'))
  tc.verifyFalse(stdlib.is_absolute_path('/foo'))
else
  tc.verifyTrue(stdlib.is_absolute_path('/foo'))
end

tc.verifyFalse(stdlib.is_absolute_path("c"))
end

function test_absolute_path(tc)
import matlab.unittest.constraints.StartsWithSubstring

tc.verifyEmpty(stdlib.absolute_path(string.empty))
tc.verifyEqual(stdlib.absolute_path(""), string(pwd))

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

function test_normalize(tc)

tc.verifyEmpty(stdlib.normalize(string.empty))
tc.verifyEqual(stdlib.normalize(""), "")

pabs = stdlib.normalize('2foo//');
tc.verifyEqual(pabs, "2foo")
end


function test_with_suffix(tc)

tc.verifyEmpty(stdlib.with_suffix(string.empty, ".nc"))
tc.verifyEqual(stdlib.with_suffix("", ""), "")

tc.verifyEqual(stdlib.with_suffix("foo.h5", ".nc"), "foo.nc")
tc.verifyEqual(stdlib.with_suffix(["foo.h5", "bar.dat"], ".nc"), ["foo.nc", "bar.nc"])

tc.verifyEqual(stdlib.with_suffix("c", ""), "c")
tc.verifyEqual(stdlib.with_suffix("c.nc", ""), "c")
tc.verifyEqual(stdlib.with_suffix("", ".nc"), ".nc")
end

end
end
