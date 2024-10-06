classdef TestJava < matlab.unittest.TestCase

methods(TestClassSetup)

function has_java(tc)
  tc.assumeTrue(stdlib.has_java)
end

end

methods(Test)

function test_filesystem_type(tc)
import matlab.unittest.constraints.IsOfClass

t = stdlib.filesystem_type(".");

tc.verifyThat(t, IsOfClass('string'))
end


function test_owner(tc)
owner = stdlib.get_owner('.');
L = strlength(owner);
tc.verifyGreaterThan(L, 0, "expected non-empty username")
end


function test_username(tc)
u = stdlib.get_username();
L = strlength(u);
tc.verifyGreaterThan(L, 0, "expected non-empty username")
end

function test_hostname(tc)
h = stdlib.hostname();
L = strlength(h);
tc.verifyGreaterThan(L, 0, "expected non-empty hostname")
end


function test_java_version(tc)
v = stdlib.java_version();
L = strlength(v);
tc.verifyGreaterThanOrEqual(L, 4)
end


function test_java_api(tc)
v = stdlib.java_api();
tc.verifyGreaterThanOrEqual(v, 8)
end


function test_hard_link_count(tc)
fn = mfilename("fullpath") + ".m";

if ispc
    tc.verifyEmpty(stdlib.hard_link_count(fn))
else
    tc.verifyGreaterThanOrEqual(stdlib.hard_link_count(fn), 1)
end

tc.verifyEmpty(stdlib.hard_link_count(tempname))
end


function test_is_parallel(tc)
import matlab.unittest.constraints.IsOfClass
tc.verifyThat(stdlib.is_parallel_worker, IsOfClass('logical'))
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
import matlab.unittest.constraints.IsFile
if ~ispc
  tc.assumeThat(stdlib.null_file, IsFile)
end
tc.verifyFalse(stdlib.is_regular_file(stdlib.null_file), "null file is not a regular file")

end


function test_touch_modtime(tc)
fn = tempname;
tc.verifyTrue(stdlib.touch(fn))
t0 = stdlib.get_modtime(fn);

pause(1.)  % empirical to avoid failing >=.  0.4 failed intermittantly
tc.verifyTrue(stdlib.set_modtime(fn))
t1 = stdlib.get_modtime(fn);

tc.verifyGreaterThanOrEqual(t1, t0)
end


function test_checkRAM(tc)
tc.assertTrue(islogical(stdlib.checkRAM(1)))
end


function test_diskfree(tc)
tc.assertTrue(isnumeric(stdlib.diskfree('/')))
tc.assertTrue(stdlib.diskfree('/') > 0, 'diskfree')
end

end

end
