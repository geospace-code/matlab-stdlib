classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'R2019b', 'pure'}) ...
    TestFilePure < matlab.unittest.TestCase


methods (Test)

function test_posix(tc)

tc.verifyEqual(stdlib.posix(''), '')
tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyEqual(stdlib.posix("c:\abc"), "c:/abc")
end

end

end

end
