classdef TestResolve < matlab.unittest.TestCase

methods(TestClassSetup)

function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end

end


methods(Test)


function test_absolute(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.EndsWithSubstring

td = tc.applyFixture(TemporaryFolderFixture).Folder;
tc.applyFixture(CurrentFolderFixture(td))

td = stdlib.posix(td);

tc.verifyEqual(stdlib.absolute(""), td)
tc.verifyEqual(stdlib.absolute("",""), td)

r = td + "/hi";
tc.verifyEqual(stdlib.absolute("hi"), r)
tc.verifyEqual(stdlib.absolute("", "hi"), r)
tc.verifyEqual(stdlib.absolute("hi", ""), r)

tc.verifyEqual(stdlib.absolute("./hi"), td + "/./hi")
tc.verifyEqual(stdlib.absolute("../hi"), td + "/../hi")

tc.verifyEqual(stdlib.absolute("there", "hi"), td + "/hi/there")

end



function test_canonical(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.EndsWithSubstring

td = tc.applyFixture(TemporaryFolderFixture).Folder;
tc.applyFixture(CurrentFolderFixture(td))

% all non-existing files

tc.verifyEqual(stdlib.canonical(""), ".")

pabs = stdlib.canonical('2foo');
tc.verifyThat(pabs, StartsWithSubstring("2foo"))

par1 = stdlib.canonical("../2foo");
tc.verifyThat(par1, StartsWithSubstring(".."))

pt1 = stdlib.canonical("bar/../2foo");
tc.verifyEqual(pt1, "2foo")

% test existing file
r = stdlib.parent(mfilename('fullpath'));
tc.verifyEqual(stdlib.canonical(fullfile(r, "..")), stdlib.parent(r))

% on windows, ~ is expanded even without expanduser
if ~ispc
tc.verifyThat(stdlib.canonical("~", false), EndsWithSubstring("~"))
end

h = stdlib.homedir;
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

tc.verifyEqual(stdlib.resolve(""), stdlib.posix(td))

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

h = stdlib.homedir;
tc.verifyEqual(stdlib.resolve("~"), h)
tc.verifyEqual(stdlib.resolve("~/"), h)
tc.verifyEqual(stdlib.resolve("~/.."), stdlib.parent(h))

tc.verifyEqual(stdlib.resolve("nobody.txt"), stdlib.join(td, "nobody.txt"))
tc.verifyEqual(stdlib.resolve("../nobody.txt"), stdlib.join(stdlib.parent(td), "nobody.txt"))

end


end

end
