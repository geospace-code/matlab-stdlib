classdef TestIsAbsolute < matlab.unittest.TestCase

properties (TestParameter)
p = init_is_absolute()
use_java = num2cell(unique([stdlib.has_java(), false]))
end

methods (Test)
function test_is_absolute(tc, p, use_java)
ok = stdlib.is_absolute(p{1}, use_java);
tc.verifyEqual(ok, p{2}, p{1})
end
end
end


function p = init_is_absolute()
p = {{"", false}, {"x", false}, {"x:", false}, {"x:/foo", false}, {"/foo", true}};
if ispc
    p{4}{2} = true;
    p{5}{2} = false;
end
end
