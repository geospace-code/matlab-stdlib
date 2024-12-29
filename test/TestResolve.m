classdef TestResolve < matlab.unittest.TestCase

properties (TestParameter)
use_java = num2cell(unique([stdlib.has_java(), false]))

p
end

methods (TestParameterDefinition, Static)

function p = init()
c = stdlib.posix(pwd());
p = {...
{"", c}, {"not-exist", c + "/not-exist"}, ...
{"a/../b", c + "/b"}, ...
{"~", stdlib.homedir()}, {"~/", stdlib.homedir()}, ...
{"~/..", stdlib.parent(stdlib.homedir())}, ...
{mfilename("fullpath") + ".m/..", stdlib.parent(mfilename("fullpath"))}, ...
{"~/not-exist/a/..", stdlib.homedir() + "/not-exist"}
};
end

end

methods (Test)

function test_resolve_relative(tc, use_java)
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.ContainsSubstring

td = stdlib.posix(pwd());

% all non-existing files

tc.verifyEqual(stdlib.resolve("", true, use_java), stdlib.posix(td))

pabs = stdlib.resolve('2foo', true, use_java);
pabs2 = stdlib.resolve('4foo', true, use_java);
tc.verifyThat(pabs, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(pabs, pabs2, 2))

par1 = stdlib.resolve("../2foo", true, use_java);
tc.verifyNotEmpty(par1)
tc.verifyThat(par1, ~ContainsSubstring(".."))

par2 = stdlib.resolve("../4foo", true, use_java);
tc.verifyTrue(strncmp(par2, pabs2, 2))

pt1 = stdlib.resolve("bar/../2foo", true, use_java);
tc.verifyNotEmpty(pt1)
tc.verifyThat(pt1, ~ContainsSubstring(".."))

va = stdlib.resolve("2foo", true, use_java);
vb = stdlib.resolve("4foo", true, use_java);
tc.verifyThat(va, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(va, vb, 2))

end

function test_resolve_fullpath(tc, p, use_java)
tc.verifyEqual(stdlib.resolve(p{1}, true, use_java), p{2})
end

end

end
