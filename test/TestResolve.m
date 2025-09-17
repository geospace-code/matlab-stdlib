classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a'}) ...
  TestResolve < matlab.unittest.TestCase

properties (TestParameter)
p = {'', "", '.', ".", ".."}
end

methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end


methods (Test)

function test_resolve_relative(tc)
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.ContainsSubstring

% all non-existing files

pabs = stdlib.resolve('2foo', false);
pabs2 = stdlib.resolve('4foo', false);
tc.verifyThat(pabs, ~StartsWithSubstring("2"))
tc.verifyThat(pabs, StartsWithSubstring(extractBefore(pabs2, 3)))

par1 = stdlib.resolve("../2foo", false);
tc.verifyNotEmpty(par1)
tc.verifyThat(par1, ContainsSubstring(".."))

par2 = stdlib.resolve("../4foo", false);
tc.verifyThat(par2, StartsWithSubstring(extractBefore(pabs2, 3)))

pt1 = stdlib.resolve("bar/../2foo", false);
tc.verifyNotEmpty(pt1)
tc.verifyThat(pt1, ContainsSubstring(".."))

va = stdlib.resolve("2foo", false);
vb = stdlib.resolve("4foo", false);
tc.verifyThat(va, ~StartsWithSubstring("2"))
tc.verifyThat(va, StartsWithSubstring(extractBefore(vb, 3)))

end

function test_resolve_fullpath(tc, p)

switch p
  case {'', "", '.', "."}, b = pwd();
  case {'..', ".."}, b = fileparts(pwd());
end

if isstring(p)
  b = string(b);
end

tc.verifyEqual(stdlib.resolve(p, true), b)
end
end

end
