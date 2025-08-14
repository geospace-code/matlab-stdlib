classdef (TestTags = {'R2019b', 'impure'}) ...
    TestSame < matlab.unittest.TestCase

properties (TestParameter)
p_same = {...
{".", pwd()}, ...
{"..", "./.."}, ...
{"..", pwd() + "/.."}, ...
{pwd(), pwd() + "/."}}

backend = init_backend({'sys', 'java', 'python', 'native'}, 'native', ~isMATLABReleaseOlderThan('R2024a'))
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods(Test)

function test_samepath(tc, p_same, backend)
r = stdlib.samepath(p_same{:}, backend);
tc.verifyClass(r, 'logical')
tc.verifyTrue(r)
end


function test_samepath_notexist(tc, backend)
t = tempname();
tc.verifyFalse(stdlib.samepath("", "", backend))
tc.verifyFalse(stdlib.samepath(t, t, backend))
end


function test_samepath_array(tc, backend)
in = [string(mfilename), string(mfilename('fullpath'))] + ".m";
r = stdlib.samepath(in, fliplr(in), backend);
tc.verifyClass(r, 'logical')
tc.verifyEqual(r, [true, true])
end

end

end
