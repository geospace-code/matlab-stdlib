classdef TestResolve < matlab.unittest.TestCase

properties (TestParameter)
p = init_resolve()
end


methods (Test)

function test_resolve_relative(tc)
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.ContainsSubstring

% all non-existing files

pabs = stdlib.resolve('2foo', true);
pabs2 = stdlib.resolve('4foo', true);
tc.verifyThat(pabs, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(pabs, pabs2, 2))

par1 = stdlib.resolve("../2foo", true);
tc.verifyNotEmpty(par1)
tc.verifyThat(par1, ~ContainsSubstring(".."))

par2 = stdlib.resolve("../4foo", true);
tc.verifyTrue(strncmp(par2, pabs2, 2))

pt1 = stdlib.resolve("bar/../2foo", true);
tc.verifyNotEmpty(pt1)
tc.verifyThat(pt1, ~ContainsSubstring(".."))

va = stdlib.resolve("2foo", true);
vb = stdlib.resolve("4foo", true);
tc.verifyThat(va, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(va, vb, 2))

end

function test_resolve_fullpath(tc, p)
tc.verifyEqual(stdlib.resolve(p{1}, true), p{2})
end

end

end


function p = init_resolve()

p = {...
{'', stdlib.posix(pwd())}, ...
{"", string(stdlib.posix(pwd()))}, ...
{'~', stdlib.homedir()}, ...
{"~", string(stdlib.homedir())}, ...
{'~/', stdlib.homedir()}, ...
{"~/", string(stdlib.homedir())}, ...
{"~/..", string(stdlib.parent(stdlib.homedir()))}, ...
{mfilename("fullpath") + ".m/..", string(stdlib.parent(mfilename("fullpath")))}, ...
{"a/../b", stdlib.posix(pwd()) + "/b"}, ...
{"not-exist", stdlib.posix(pwd()) + "/not-exist"}, ...
{"~/not-exist/a/..", stdlib.homedir() + "/not-exist"}...
};
end
