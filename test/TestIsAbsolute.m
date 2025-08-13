classdef (TestTags = {'R2019b', 'pure'}) ...
    TestIsAbsolute < matlab.unittest.TestCase

properties (TestParameter)
p = {{"", false}, {"x", false}, {"x:", false}}
pu = {{"x:/foo", false}, {"/foo", true}}
pw = {{"x:/foo", true}, {"/foo", false}}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test)

function test_is_absolute(tc, p)
ok = stdlib.is_absolute(p{1});
tc.verifyEqual(ok, p{2}, p{1})
end

end


methods (Test, TestTags={'unix'})

function test_is_absolute_unix(tc, pu)
tc.assumeTrue(isunix())
ok = stdlib.is_absolute(pu{1});
tc.verifyEqual(ok, pu{2}, pu{1})
end

end


methods (Test, TestTags={'windows'})

function test_is_absolute_windows(tc, pw)
tc.assumeTrue(ispc())
ok = stdlib.is_absolute(pw{1});
tc.verifyEqual(ok, pw{2}, pw{1})
end

end

end
