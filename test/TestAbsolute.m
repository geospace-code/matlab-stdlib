classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2019b', 'impure'}) ...
    TestAbsolute < matlab.unittest.TestCase

properties (TestParameter)
p1 = {'', "hi", "./hi", "../hi"};
p2 = {{'', ''}, {'', 'hi'}, {"hi", ""}, {'there', 'hi'}};
end


methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods(Test)

function test_absolute1arg(tc, p1)

if strlength(p1)
  r = append(pwd(), '/', p1);
else
  r = pwd();
end

rabs = stdlib.absolute(p1);

tc.verifyClass(rabs, class(p1))
tc.verifyEqual(rabs, r)
end


function test_absolute2arg(tc, p2)

if strlength(p2{2})
  r = append(pwd(), '/', p2{2});
else
  r = pwd();
end

if strlength(p2{1})
  r = append(r, '/', p2{1});
end

rabs = stdlib.absolute(p2{1}, p2{2});

tc.verifyClass(rabs, class(p2{1}))
tc.verifyEqual(rabs, r)
end

end

end
