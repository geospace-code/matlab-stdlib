classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2019b'}) ...
    TestSubprocess < SubprocessRunAbstract

properties (Constant)
  runFcn = @stdlib.subprocess_run
end

end
