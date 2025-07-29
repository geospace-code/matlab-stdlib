classdef TestSame < matlab.unittest.TestCase

properties (TestParameter)
p_same = {...
{"..", "./.."}, ...
{"..", pwd() + "/.."}, ...
{pwd(), pwd() + "/."}}

same_fun = {@stdlib.samepath, @stdlib.sys.samepath, @stdlib.python.samepath}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods(Test)

function test_samepath(tc, p_same, same_fun)
is_capable(tc, same_fun)

tc.verifyTrue(same_fun(p_same{1}, p_same{2}))
end

function test_samepath_notexist(tc, same_fun)
is_capable(tc, same_fun)

tc.verifyFalse(same_fun("", ""))
t = tempname();
tc.verifyFalse(same_fun(t, t))
end

end

end
