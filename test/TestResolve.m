classdef TestResolve < matlab.unittest.TestCase

methods (Test)

function test_resolve_non_exist(tc)
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.ContainsSubstring

td = stdlib.posix(pwd());

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

end

function test_resolve_exist(tc)

td = stdlib.posix(pwd());

r = stdlib.parent(mfilename('fullpath'));
rp = stdlib.parent(r);
tc.verifyEqual(stdlib.resolve(rp), stdlib.parent(r))

h = stdlib.homedir();
tc.verifyEqual(stdlib.resolve("~"), h)
tc.verifyEqual(stdlib.resolve("~/"), h)
tc.verifyEqual(stdlib.resolve("~/.."), stdlib.parent(h))

tc.verifyEqual(stdlib.resolve("nobody.txt"), td + "/nobody.txt")
tc.verifyEqual(stdlib.resolve("../nobody.txt"), stdlib.parent(td) + "/nobody.txt")

end


end

end
