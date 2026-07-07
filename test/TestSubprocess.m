classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    TestSubprocess < SubprocessRunAbstract

properties (Constant)
  runFcn = @stdlib.subprocess_run
end

end
