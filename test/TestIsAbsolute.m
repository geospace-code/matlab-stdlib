classdef TestIsAbsolute < matlab.unittest.TestCase

properties (TestParameter)
p = init_is_absolute()
end

methods (Test)
function test_is_absolute(tc, p)
ok = stdlib.is_absolute(p{1});
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
