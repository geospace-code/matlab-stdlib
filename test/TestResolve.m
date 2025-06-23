classdef TestResolve < matlab.unittest.TestCase

properties (TestParameter)
p = init_resolve()
end


methods (Test)

function test_resolve_relative(tc)
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.ContainsSubstring

% all non-existing files

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

function test_resolve_fullpath(tc, p)
tc.verifyEqual(stdlib.resolve(p{1}), p{2}, ...
    sprintf("mex: %d", stdlib.is_mex_fun("stdlib.parent")))
end

end

end


function p = init_resolve()

p = {...
{'', stdlib.posix(pwd())}, ...
{"", string(stdlib.posix(pwd()))}, ...
{"a/../b", stdlib.posix(pwd()) + "/b"}, ...
{"not-exist", stdlib.posix(pwd()) + "/not-exist"}, ...
{"./not-exist/a/..", stdlib.posix(pwd()) + "/not-exist"}...
};

p{end+1} = {strcat(mfilename("fullpath"), '.m/..'), stdlib.parent(mfilename("fullpath"))};
p{end+1} = cellfun(@string, p{end});

if stdlib.is_mex_fun("stdlib.parent")
  p{end-1,2} = string(p{end-1,2});
end

end
