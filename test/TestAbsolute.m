classdef TestAbsolute < matlab.unittest.TestCase

properties (TestParameter)
p1 = init1arg()
p2 = init2arg()
end


methods(Test)

function test_absolute1arg(tc, p1)
tc.verifyEqual(stdlib.absolute(p1{1}), p1{2})
end

function test_absolute2arg(tc, p2)
tc.verifyEqual(stdlib.absolute(p2{1}, p2{2}), p2{3})
end

end

end


function p = init1arg()
td = stdlib.posix(pwd());
r = td + "/hi";

p = {{"", td}, {"hi", r}, {"./hi", td + "/./hi"}, {"../hi", td + "/../hi"}, {"file:///", ""}};
end

function p = init2arg()
td = stdlib.posix(pwd());
r = td + "/hi";

p = {{"", "", td}, {"", "hi", r}, {"hi", "", r}, {"there", "hi", td + "/hi/there"}, {"file:///", "file:///", ""}};
end
