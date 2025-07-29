classdef TestResolve < matlab.unittest.TestCase

properties
td
end

properties (TestParameter)
p = {'', "", ".", ".."}
end

methods(TestClassSetup)

function pkg_path(tc)
slp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(slp)
end

function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(tc.td))
end
end

methods(TestClassTeardown)
function remove_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  [s, m, i] = rmdir(tc.td, 's');
  if ~s, warning(i, "Failed to remove temporary directory %s: %s", tc.td, m); end
end
end
end


methods (Test, TestTags="impure")

function test_resolve_relative(tc)
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.ContainsSubstring

% all non-existing files

pabs = stdlib.resolve('2foo');
pabs2 = stdlib.resolve('4foo');
tc.verifyThat(pabs, ~StartsWithSubstring("2"))
tc.verifyThat(pabs, StartsWithSubstring(extractBefore(pabs2, 3)))

par1 = stdlib.resolve("../2foo");
tc.verifyNotEmpty(par1)
tc.verifyThat(par1, ~ContainsSubstring(".."))

par2 = stdlib.resolve("../4foo");
tc.verifyThat(par2, StartsWithSubstring(extractBefore(pabs2, 3)))

pt1 = stdlib.resolve("bar/../2foo");
tc.verifyNotEmpty(pt1)
tc.verifyThat(pt1, ~ContainsSubstring(".."))

va = stdlib.resolve("2foo");
vb = stdlib.resolve("4foo");
tc.verifyThat(va, ~StartsWithSubstring("2"))
tc.verifyThat(va, StartsWithSubstring(extractBefore(vb, 3)))

end

function test_resolve_fullpath(tc, p)

  a = p;
  switch a
    case {'', "", '.', "."}, b = string(tc.td);
    case {'..', ".."}, b = string(fileparts(tc.td));
  end

tc.verifyEqual(stdlib.resolve(a), b)
end

end

end
