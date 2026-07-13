classdef TestResolve < WorkingClassDir

properties (TestParameter)
p = {'', "", '.', ".", ".."}
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
  case {'', "", '.', "."}, b = string(pwd());
  case {'..', ".."}, b = fileparts(string(pwd()));
end

tc.verifyEqual(stdlib.resolve(p, true), b)
end
end

end
