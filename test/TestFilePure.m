classdef TestFilePure < matlab.unittest.TestCase

properties (TestParameter)
p = init_root_name()
pds = {{'/', '/'}, {'a//b', 'a/b'}, {'a//b/', 'a/b'}, {'a//b/c', 'a/b/c'}};
end


methods (Test)

function test_posix(tc)

tc.verifyEqual(stdlib.posix(''), '')
tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyEqual(stdlib.posix("c:\abc"), "c:/abc")
end
end


function test_drop_slash(tc, pds)
import matlab.unittest.constraints.Matches
tc.verifyThat(stdlib.drop_slash(pds{1}), Matches(pds{2}))
end

function test_root_name(tc, p)
tc.verifyEqual(stdlib.root_name(p{1}), p{2})
end

end
end


function p = init_root_name()

p = {{"", ""}, ...
{"a/b", ""}, ...
{'/etc', ''}, ...
{"c:/etc", ""}
};

if ispc
  p{4}{2} = "c:";
end

end
