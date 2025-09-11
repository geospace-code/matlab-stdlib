classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2019b', 'impure'}) ...
    TestSys < matlab.unittest.TestCase


properties (TestParameter)
B_jps = {'java', 'python', 'sys'}
B_jdps = {'java', 'dotnet', 'python', 'sys'}
B_jdpps = {'java', 'dotnet', 'perl', 'python', 'sys'}
B_dpp = {'dotnet', 'perl', 'python'}
B_dps = {'dotnet', 'python', 'sys'}
end


methods (Test)

function test_is_admin(tc, B_jdpps)
[i, b] = stdlib.is_admin(B_jdpps);
tc.assertEqual(char(b), B_jdpps)
tc.verifyClass(i, "logical")

if ismember(B_jdpps, stdlib.Backend().select('is_admin'))
  tc.verifyNotEmpty(i)
else
  tc.verifyEmpty(i)
end
end


function test_cpu_load(tc, B_jps)
[r, b] = stdlib.cpu_load(B_jps);
tc.assertClass(r, 'double')
tc.assertEqual(char(b), B_jps)

if ismember(B_jps, stdlib.Backend().select('cpu_load'))
  tc.verifyGreaterThanOrEqual(r, 0.)
  % some CI systems report 0
else
  tc.verifyEmpty(r)
end
end


function test_process_priority(tc, B_dps)
import matlab.unittest.constraints.IsSubsetOf
[r, b] = stdlib.get_process_priority(B_dps);
tc.assertEqual(char(b), B_dps)
tc.verifyThat({class(r)}, IsSubsetOf({'double', 'char'}))

if ismember(B_dps, stdlib.Backend().select('get_process_priority'))
  tc.verifyNotEmpty(r)
else
  tc.verifyEmpty(r)
end
end


function test_os_version(tc, B_jdps)
[os, ver, b] = stdlib.os_version(B_jdps);
tc.assertEqual(char(b), B_jdps)

tc.verifyClass(os, 'char')
tc.verifyClass(ver, 'char')

if ismember(B_jdps, stdlib.Backend().select('os_version'))
  tc.verifyGreaterThan(strlength(os), 0, "expected non-empty os")
  tc.verifyGreaterThan(strlength(ver), 0, "expected non-empty version")
else
  tc.verifyEmpty(os)
  tc.verifyEmpty(ver)
end
end


function test_checkRAM(tc)
tc.verifyTrue(stdlib.checkRAM(1, "double"))
end


function test_hostname(tc, B_jdps)
[h, b] = stdlib.hostname(B_jdps);
tc.assertEqual(char(b), B_jdps)
tc.verifyClass(h, 'char')

if ismember(B_jdps, stdlib.Backend().select('hostname'))
  tc.verifyGreaterThan(strlength(h), 0)
else
  tc.verifyEmpty(h)
end
end


function test_get_uid(tc, B_dpp)
[u, b] = stdlib.get_uid(B_dpp);
tc.assertEqual(char(b), B_dpp)

if ismember(B_dpp, stdlib.Backend().select('get_uid'))
  if ispc()
    tc.verifyClass(u, 'char')
    tc.verifyGreaterThan(strlength(u), 0)
  else
    tc.verifyNotEmpty(u)
  end
else
  tc.verifyEmpty(u)
end
end


function test_username(tc, B_jdps)
[u, b] = stdlib.get_username(B_jdps);
tc.assertEqual(char(b), B_jdps)
tc.verifyClass(u, 'char')

if ismember(B_jdps, stdlib.Backend().select('get_username'))
  tc.verifyGreaterThan(strlength(u), 0)
else
  tc.verifyEmpty(u)
end
end


function test_cpu_arch(tc)
arch = stdlib.cpu_arch();
tc.verifyClass(arch, 'char')
tc.verifyGreaterThan(strlength(arch), 0, "CPU architecture should not be empty")
end

function test_ram_total(tc, B_jdps)
[t, b] = stdlib.ram_total(B_jdps);
tc.assertEqual(char(b), B_jdps)
tc.verifyClass(t, 'uint64')

if ismember(B_jdps, stdlib.Backend().select('ram_total'))
  tc.verifyGreaterThan(t, 0)
else
  tc.verifyEmpty(t)
end
end


function test_ram_free(tc, B_jps)
% don't verify less than or equal to total due to shaky system measurements'
[f, b] = stdlib.ram_free(B_jps);
tc.assertEqual(char(b), B_jps)
tc.verifyClass(f, 'uint64')

if ismember(B_jps, stdlib.Backend().select('ram_free'))
  tc.verifyGreaterThan(f, 0)
else
  tc.verifyEmpty(f)
end
end

end
end
