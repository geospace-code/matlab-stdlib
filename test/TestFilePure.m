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

tc.verifyEqual(stdlib.filename(""), "")

tc.verifyEqual(stdlib.filename("/foo/bar/baz"), "baz")
tc.verifyEqual(stdlib.filename("/foo/bar/baz/"), "")

tc.verifyEqual(stdlib.filename("foo/bar/baz.txt"), "baz.txt")
tc.verifyEqual(stdlib.filename("foo/bar/baz.txt.gz"), "baz.txt.gz")

end


function test_parent(tc)

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


function test_is_absolute_path(tc)

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


function test_normalize(tc)

tc.verifyEqual(stdlib.normalize(""), "")

pabs = stdlib.normalize('2foo//');
tc.verifyEqual(pabs, "2foo")
end


function test_with_suffix(tc)

tc.verifyEqual(stdlib.with_suffix("", ""), "")

tc.verifyEqual(stdlib.with_suffix("foo.h5", ".nc"), "foo.nc")

tc.verifyEqual(stdlib.with_suffix("c", ""), "c")
tc.verifyEqual(stdlib.with_suffix("c.nc", ""), "c")
tc.verifyEqual(stdlib.with_suffix("", ".nc"), ".nc")
end

end
end
