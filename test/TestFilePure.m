classdef TestFilePure < matlab.unittest.TestCase

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end


methods (Test, TestTags=["R2019b", "pure"])

function test_posix(tc)

tc.verifyEqual(stdlib.posix(''), '')
tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyEqual(stdlib.posix("c:\abc"), "c:/abc")
end

end

end

end
