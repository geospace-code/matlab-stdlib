classdef TestJava < matlab.unittest.TestCase

properties (TestParameter)
Ps = {"."}
end


methods (Test, TestTags=["java", "unix"])

function test_inode(tc)
tc.assumeFalse(ispc(), "not for Windows")
tc.assumeGreaterThanOrEqual(stdlib.java_api(), 11)

tc.verifyEqual(stdlib.inode("."), stdlib.inode(pwd()))
end


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


function test_os_version(tc)
[os, ver] = stdlib.os_version();
tc.verifyGreaterThan(strlength(os), 0, "expected non-empty os")
tc.verifyGreaterThan(strlength(ver), 0, "expected non-empty version")
end

function test_hard_link_count(tc)
fn = mfilename("fullpath") + ".m";

if ispc
    tc.verifyEmpty(stdlib.hard_link_count(fn))
else
    tc.verifyGreaterThanOrEqual(stdlib.hard_link_count(fn), 1)
end
end


function test_is_parallel(tc)
tc.verifyClass(stdlib.is_parallel_worker, 'logical')
end


function test_ram(tc)
tc.verifyGreaterThan(stdlib.ram_total(), 0)
tc.verifyGreaterThan(stdlib.ram_free(), 0)
end


function test_cpu_count(tc)
tc.verifyGreaterThan(stdlib.cpu_count(), 0)
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


function test_get_modtime(tc)
tc.verifyEmpty(stdlib.get_modtime(""))
end

function test_set_modtime(tc)
tc.verifyEqual(stdlib.set_modtime("", datetime("now")), false)
end


function test_checkRAM(tc)
tc.verifyClass(stdlib.checkRAM(1, "double"), "logical")
end

end

end
