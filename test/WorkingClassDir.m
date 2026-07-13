classdef (Abstract) WorkingClassDir < StdlibPath

methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end

end
