classdef TestCanonical < matlab.unittest.TestCase

properties (TestParameter)
p_canonical = ...
{{"", ""}, {"not-exist", "not-exist"}, {"a/../b", "b"}, ...
{"~", test_homedir()}, {"~/", test_homedir()}, ...
{"~/..", stdlib.parent(test_homedir())}, ...f
{mfilename("fullpath") + ".m/..", stdlib.parent(mfilename("fullpath"))}};
end


methods(Test)

function test_canonical(tc, p_canonical)
tc.verifyEqual(stdlib.canonical(p_canonical{1}), p_canonical{2})
end

function test_static(tc)
% ~ is expanded even without expanduser when path exists
tc.verifyEqual(stdlib.canonical("~/nobody/a/..", false), "~/nobody")
end

end

end
