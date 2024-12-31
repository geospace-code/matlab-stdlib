classdef TestCanonical < matlab.unittest.TestCase

properties(TestParameter)
use_java = num2cell(unique([stdlib.has_java(), false]))

p = {{"", ""}, ...
{"not-exist", "not-exist"}, ...
{"a/../b", "b"}, ...
{"~", stdlib.homedir()}, ...
{"~/", stdlib.homedir()}, ...
{"~/..", stdlib.parent(stdlib.homedir())}, ...
{mfilename("fullpath") + ".m/..", stdlib.parent(mfilename("fullpath"))}, ...
{"~/not-exist/a/..", stdlib.homedir() + "/not-exist"}
};
end


methods(Test)

function test_canonical(tc, p, use_java)
tc.verifyEqual(stdlib.canonical(p{1}, true, use_java), p{2})
end

end

end
