classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2016a', 'pure'}) ...
    TestFilePure < matlab.unittest.TestCase


methods (Test)

function test_posix(tc)

tc.verifyEqual(stdlib.posix(''), '')

if ispc
  tc.verifyEqual(stdlib.posix('c:\abc'), 'c:/abc')
end

end

end

end
