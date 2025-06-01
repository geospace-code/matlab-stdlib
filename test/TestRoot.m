classdef TestRoot < matlab.unittest.TestCase

properties (TestParameter)
p = init_root()
end

methods (Test)
function test_root(tc, p)
tc.verifyEqual(stdlib.root(p{1}), p{2})
end
end

end


function p = init_root()

p = {{"", ""}, ...
{"a/b", ""}, ...
{"./a/b", ""}, ...
{'/etc', '/'}, ...
{"c:", ""}, ...
{"c:/etc", ""}};

if ispc
p{5}{2} = "c:";
p{6}{2} = "c:/";
end

end
