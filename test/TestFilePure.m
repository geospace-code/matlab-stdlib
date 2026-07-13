classdef (TestTags = {'pure'}) TestFilePure < StdlibPath


methods (Test)

function test_posix(tc)

tc.verifyEqual(stdlib.posix(''), '')

if ispc
  tc.verifyEqual(stdlib.posix('c:\abc'), 'c:/abc')
end

end

end

end
