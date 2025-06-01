classdef TestAbsolute < matlab.unittest.TestCase

properties
td
end

properties (TestParameter)
p1 = {'', "", "hi", "./hi", "../hi"};
p2 = {{'', ''}, {'', ""}, {"", ''}, {"", ""}, {"", "hi"}, {"hi", ""}, {'there', "hi"}};
end


methods(TestClassSetup)
function set_cwd(tc)
import matlab.unittest.fixtures.CurrentFolderFixture
tc.td = stdlib.posix(tc.createTemporaryFolder());
tc.applyFixture(CurrentFolderFixture(tc.td))
end
end


methods(Test)

function test_absolute1arg(tc, p1)

r = tc.td;

if strlength(p1)
  r = strcat(r, '/', p1);
end

if isstring(p1)
  r = string(r);
end

tc.verifyEqual(stdlib.absolute(p1), r)
end


function test_absolute2arg(tc, p2)

r = tc.td;

if strlength(p2{2})
  r = strcat(r, '/', p2{2});
end

if strlength(p2{1})
  r = strcat(r, '/', p2{1});
end

if isstring(p2{1})
  r = string(r);
end

tc.verifyEqual(stdlib.absolute(p2{1}, p2{2}), r)
end

end

end
