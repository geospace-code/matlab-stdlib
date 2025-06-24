classdef TestCanonical < matlab.unittest.TestCase

properties(TestParameter)
p = {{'', ''}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{"a/../b", "b"}, ...
{strcat(mfilename("fullpath"), '.m/..'), stdlib.parent(mfilename("fullpath"))}, ...
{"not-exist/a/..", "not-exist"}, ...
{"./not-exist", "not-exist"}, ...
{"../not-exist", "../not-exist"}
};
end


methods(Test)

function test_canonical(tc, p)
tc.verifyEqual(stdlib.canonical(p{1}), p{2})
end

end

end
