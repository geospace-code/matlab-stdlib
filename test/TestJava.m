classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'java'}) ...
    TestJava < matlab.unittest.TestCase


methods(Test)

function test_java_vendor(tc)
v = stdlib.java.vendor();
tc.verifyGreaterThan(strlength(v), 0)
end


function test_java_version(tc)
v = stdlib.java.version();
tc.verifyGreaterThanOrEqual(strlength(v), 4)
end


function test_java_api(tc)
v = stdlib.java.api();
tc.assertGreaterThanOrEqual(v, 1.8, 'Java Specification Version >= 1.8 is required for Matlab-stdlib')
end


function test_java_home(tc)
h = stdlib.java.home();
tc.verifyClass(h, 'char')
tc.verifyThat(h, matlab.unittest.constraints.IsFolder, 'Java home folder does not exist')
end


function test_is_regular_file(tc)
tc.verifyFalse(stdlib.java.is_regular_file(stdlib.null_file()), 'null file is not a regular file')
end


end

end
