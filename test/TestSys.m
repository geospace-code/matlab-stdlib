classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    TestSys < matlab.unittest.TestCase


properties (TestParameter)
B_jps = {'java', 'python', 'shell'}
B_jdps = {'java', 'dotnet', 'python', 'shell'}
B_dp = {'dotnet', 'python'}
B_dps = {'dotnet', 'python', 'shell'}
end


methods (Test)

function test_is_admin(tc, B_jdps)
[i, b] = stdlib.is_admin(B_jdps);

if ismember(B_jdps, stdlib.Backend().select('is_admin'))
  tc.assertMatches(b, B_jdps)
  tc.verifyClass(i, 'logical')
else
  tc.verifyEqual(i, missing)
end
end


function test_cpu_load(tc, B_jps)
[r, b] = stdlib.cpu_load(B_jps);

if ismember(B_jps, stdlib.Backend().select('cpu_load'))
  tc.assertMatches(b, B_jps)
  tc.assertClass(r, 'double')
  tc.verifyGreaterThanOrEqual(r, 0.)
  % some CI systems report 0
else
  tc.verifyEqual(r, missing)
end
end


function test_process_priority(tc, B_dps)
import matlab.unittest.constraints.IsSubsetOf
[r, b] = stdlib.get_process_priority(B_dps);

if ismember(B_dps, stdlib.Backend().select('get_process_priority'))
  tc.assertMatches(b, B_dps)
  tc.verifyThat({class(r)}, IsSubsetOf({'double', 'char'}))
else
  tc.verifyEqual(r, missing)
end
end


function test_os_version(tc, B_jdps)
[os, ver, b] = stdlib.os_version(B_jdps);

if ismember(B_jdps, stdlib.Backend().select('os_version'))
  tc.assertMatches(b, B_jdps)
  tc.verifyClass(os, 'char')
  tc.verifyClass(ver, 'char')
  tc.verifyGreaterThan(strlength(os), 0, 'expected non-empty os')
  tc.verifyGreaterThan(strlength(ver), 0, 'expected non-empty version')
else
  tc.verifyEqual(os, missing)
  tc.verifyEqual(ver, missing)
end
end


function test_checkRAM(tc)
tc.verifyTrue(stdlib.checkRAM(1, 'double'))
end


function test_hostname(tc, B_jdps)
[h, b] = stdlib.hostname(B_jdps);

if ismember(B_jdps, stdlib.Backend().select('hostname'))
  tc.assertMatches(b, B_jdps)
  tc.verifyClass(h, 'char')
  tc.verifyGreaterThan(strlength(h), 0)
else
  tc.verifyEqual(h, missing)
end
end


function test_get_uid(tc, B_dp)
[u, b] = stdlib.get_uid(B_dp);

if ismember(B_dp, stdlib.Backend().select('get_uid'))
  tc.assertMatches(b, B_dp)
  tc.verifyClass(u, 'double')
else
  tc.verifyEqual(u, missing)
end
end


function test_username(tc, B_jdps)
[u, b] = stdlib.get_username(B_jdps);

if ismember(B_jdps, stdlib.Backend().select('get_username'))
  tc.assertMatches(b, B_jdps)
  tc.verifyClass(u, 'char')
  tc.verifyGreaterThan(strlength(u), 0)
else
  tc.verifyEqual(u, missing)
end
end


function test_cpu_arch(tc)
arch = stdlib.cpu_arch();
tc.verifyClass(arch, 'char')
tc.verifyGreaterThan(strlength(arch), 0, 'CPU architecture should not be empty')
end

function test_ram_total(tc, B_jdps)
[t, b] = stdlib.ram_total(B_jdps);

if ismember(B_jdps, stdlib.Backend().select('ram_total'))
  tc.assertMatches(b, B_jdps)
  tc.verifyClass(t, 'uint64')
  tc.verifyGreaterThan(t, 0)
else
  tc.verifyEqual(t, missing)
end
end


function test_ram_free(tc, B_jps)
% don't verify less than or equal to total due to shaky system measurements'
[f, b] = stdlib.ram_free(B_jps);

if ismember(B_jps, stdlib.Backend().select('ram_free'))
  tc.assertMatches(b, B_jps)
  tc.verifyClass(f, 'uint64')
  tc.verifyGreaterThan(f, 0)
else
  tc.verifyEqual(f, missing)
end
end

end
end
