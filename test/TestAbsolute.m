classdef TestAbsolute < matlab.unittest.TestCase

properties (TestParameter)
use_java = num2cell(unique([stdlib.has_java(), false]))
p1
p2
end

methods (TestParameterDefinition, Static)
function [p1, p2] = init()

td = stdlib.posix(pwd());
r = td + "/hi";

p1 = {{"", td}, {"hi", r}, {"./hi", td + "/./hi"}, {"../hi", td + "/../hi"}};
p2 = {{"", "", td}, {"", "hi", r}, {"hi", "", r}, {"there", "hi", td + "/hi/there"}};

end
end


methods(Test)

function test_absolute_onearg(tc, p1)
tc.verifyEqual(stdlib.absolute(p1{1}), p1{2})
end

function test_absolute_twoarg(tc, p2, use_java)
tc.verifyEqual(stdlib.absolute(p2{1}, p2{2}, false, use_java), p2{3})
end

end

end
