classdef TestIsAbsolute < WorkingClassDir

properties (TestParameter)
p = {{'', false}, {'x', false}, {'x:', false}, {'x:/foo', ispc()}, {'/foo', ~ispc()}}
end


methods (Test)

function test_is_absolute(tc, p)
ok = stdlib.is_absolute(p{1});
tc.verifyEqual(ok, p{2}, p{1})
end

end
end
