classdef TestJava < matlab.unittest.TestCase


methods(Test, TestTags="java")

function test_java_vendor(tc)
v = stdlib.java_vendor();
tc.verifyGreaterThan(strlength(v), 0)
end


function test_java_version(tc)
v = stdlib.java_version();
tc.verifyGreaterThanOrEqual(strlength(v), 4)
end


function test_java_api(tc)
v = stdlib.java_api();
tc.assertGreaterThanOrEqual(v, 1.8, "Java Specification Version >= 1.8 is required for Matlab-stdlib")
end


function test_cpu_load(tc)
tc.verifyGreaterThanOrEqual(stdlib.cpu_load(), 0)
end


function test_is_regular_file(tc)
tc.verifyFalse(stdlib.is_regular_file(stdlib.null_file()), "null file is not a regular file")
end


end

end
