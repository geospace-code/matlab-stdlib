classdef (TestTags = {'R2019b', 'impure'}) ...
  TestResolve < matlab.unittest.TestCase

properties (TestParameter)
p = {'', "", ".", ".."}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)

  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test)

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
  case {'', "", '.', "."}, b = string(pwd());
  case {'..', ".."}, b = string(fileparts(pwd()));
end

tc.verifyEqual(stdlib.resolve(a), b)
end

function test_resolve_array(tc)
in = ["", "hi", "/ok", "not-exist/a/.."];
c = stdlib.resolve(in);

exp = [pwd(), fullfile(pwd(), "hi"), filesep + "ok", fullfile(pwd(), "not-exist")];
if ispc()
  exp(3) = fullfile(pwd(), "ok");
end

tc.verifyEqual(c, exp)
end

end

end
