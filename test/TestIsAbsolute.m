classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2016a', 'pure'}) ...
    TestIsAbsolute < matlab.unittest.TestCase

properties (TestParameter)
p = init_p()
end


methods (Test)

function test_is_absolute(tc, p)
ok = stdlib.is_absolute(p{1});
tc.verifyEqual(ok, p{2}, p{1})
end

end
end


function p = init_p()
p = {{'', false}, {'x', false}, {'x:', false}};

if ispc()
  p = [p, {{'x:/foo', true}, {'/foo', false}}];
else
  p = [p, {{'x:/foo', false}, {'/foo', true}}];
end

end
