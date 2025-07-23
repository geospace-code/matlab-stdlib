classdef TestJava < matlab.unittest.TestCase

properties
td
end

methods(TestClassSetup)
function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
end
end

methods(TestClassTeardown)
function remove_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  rmdir(tc.td, 's');
end
end
end

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


function test_touch_modtime(tc)

fn = fullfile(tc.td, "modtime.txt");

tc.verifyTrue(stdlib.touch(fn, datetime("yesterday")))
t0 = stdlib.get_modtime(fn);

tc.verifyTrue(stdlib.set_modtime(fn, datetime("now")))
t1 = stdlib.get_modtime(fn);

tc.verifyGreaterThanOrEqual(t1, t0)
end

function test_set_modtime(tc)
tc.verifyEqual(stdlib.set_modtime("", datetime("now")), false)
end

end

end
