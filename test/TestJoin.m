classdef (TestTags = {'R2019b', 'pure'}) ...
    TestJoin < matlab.unittest.TestCase

properties (TestParameter)
p = init_join()
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end

methods (Test)
function test_join(tc, p)
tc.verifyEqual(stdlib.join(p{1}, p{2}), p{3})
end
end

end


function p = init_join()

p = {{"", "", ""}, ...
{"a", "", "a"}, ...
{"", "a", "a"}, ...
{"a/b/", "c", "a/b/c"}, ...
{"/", "", "/"}, ...
{"", "/", "/"}, ...
{"a", "b", "a/b"}, ...
{"a/b/../", "c/d/..", "a/b/../c/d/.."}, ...
{"a/b", "..", "a/b/.."}, ...
{"a/b", "c/d", "a/b/c/d"}, ...
{"ab/cd", "/ef", "/ef"}, ...
{matlabroot, "bin", matlabroot + "/bin"}
};


end
