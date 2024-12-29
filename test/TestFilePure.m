classdef TestFilePure < matlab.unittest.TestCase

properties (TestParameter)
p = init_root_name()
end


methods (Test)

function test_posix(tc)
import matlab.unittest.constraints.ContainsSubstring

tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyThat(stdlib.posix("c:\foo"), ~ContainsSubstring("\"))
end
end

function test_root_name(tc, p)
tc.verifyEqual(stdlib.root_name(p{1}), p{2})
end

end
end


function p = init_root_name()

p = {{"", ""}, ...
{"a/b", ""}, ...
{"/etc", ""}, ...
{"c:/etc", ""}};

if ispc
  p{4}{2} = "c:";
end

end
