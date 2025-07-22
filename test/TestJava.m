classdef TestJava < matlab.unittest.TestCase

properties (TestParameter)
Ps = {"."}
end


methods (Test, TestTags=["java", "unix"])


function test_owner(tc, Ps)

s = stdlib.get_owner(Ps);
tc.verifyClass(s, 'string')
L = strlength(s);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(L, 0)
else
  tc.verifyEqual(L, 0)
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
tc.assertGreaterThanOrEqual(v, 8, "Java API >= 8 is required for Matlab-stdlib")
end


function test_hard_link_count(tc)
fn = mfilename("fullpath") + ".m";

if ispc
    tc.verifyEmpty(stdlib.hard_link_count(fn))
else
    tc.verifyGreaterThanOrEqual(stdlib.hard_link_count(fn), 1)
end
end


function test_cpu_load(tc)
tc.verifyGreaterThanOrEqual(stdlib.cpu_load(), 0)
end


function test_is_regular_file(tc)
tc.verifyFalse(stdlib.is_regular_file(stdlib.null_file()), "null file is not a regular file")
end


function test_touch_modtime(tc)

tf = tc.createTemporaryFolder();

fn = fullfile(tf, "modtime.txt");

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
