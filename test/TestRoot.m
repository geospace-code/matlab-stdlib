classdef TestRoot < matlab.unittest.TestCase

properties (TestParameter)
use_java = num2cell(unique([stdlib.has_java(), false]))
p = init_root()
end

methods (Test)
function test_root(tc, p, use_java)
tc.verifyEqual(stdlib.root(p{1}, use_java), p{2})
end
end

end


function p = init_root()

p = {{"", ""}, ...
{"a/b", ""}, ...
{"./a/b", ""}, ...
{"/etc", "/"}, ...
{"c:", ""}, ...
{"c:/etc", ""}};

if ispc
p{5}{2} = "c:";
p{6}{2} = "c:/";
end
end
