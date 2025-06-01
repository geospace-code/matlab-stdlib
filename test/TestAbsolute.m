classdef TestAbsolute < matlab.unittest.TestCase

properties
td
end


properties (TestParameter)
p1
p2
end


methods (TestParameterDefinition, Static)

function p1 = init1arg()
p1 = {"", "hi", "./hi", "../hi"};
end

function p2 = init2arg()
p2 = {{"", ""}, {"", "hi"}, {"hi", ""}, {"there", "hi"}};
end

end


methods(TestClassSetup)
function set_cwd(tc)
import matlab.unittest.fixtures.CurrentFolderFixture
tc.td = string(stdlib.posix(tc.createTemporaryFolder()));
tc.applyFixture(CurrentFolderFixture(tc.td))
end
end


methods(Test)

function test_absolute1arg(tc, p1)

r = tc.td;

if strlength(p1)
  r = r + "/" + p1;
end

tc.verifyEqual(stdlib.absolute(p1), r)
end


function test_absolute2arg(tc, p2)

r = tc.td;

if strlength(p2{2})
  r = r + "/" + p2{2};
end

if strlength(p2{1})
  r = r + "/" + p2{1};
end

tc.verifyEqual(stdlib.absolute(p2{1}, p2{2}), r)
end

end

end
