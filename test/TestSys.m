classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2021a', 'impure'}) ...
    TestSys < matlab.unittest.TestCase


properties (TestParameter)
B_cpu_load
B_ram_free
B_ram_total
B_is_admin
B_os_version
B_hostname
B_username
B_get_uid
B_get_process_priority
end

methods (TestParameterDefinition, Static)
function [B_cpu_load, B_ram_free, B_ram_total, B_is_admin, B_os_version, B_hostname, B_username, B_get_uid, B_get_process_priority] = setupBackends()
B_cpu_load = init_backend("cpu_load");
B_ram_free = init_backend("ram_free");
B_ram_total = init_backend("ram_total");
B_is_admin = init_backend("is_admin");
B_os_version = init_backend("os_version");
B_hostname = init_backend("hostname");
B_username = init_backend("get_username");
B_get_uid = init_backend('get_uid');
B_get_process_priority = init_backend('get_process_priority');
end
end


methods (Test)

function test_is_admin(tc, B_is_admin)
i = stdlib.is_admin(B_is_admin);
tc.verifyClass(i, "logical")
tc.verifyNotEmpty(i)
end


function test_cpu_load(tc, B_cpu_load)
[r, b] = stdlib.cpu_load(B_cpu_load);
tc.assertClass(r, 'double')
tc.assertEqual(char(b), B_cpu_load)

if ispc() && B_cpu_load == "python"
  tc.verifyEmpty(r)
else
  tc.verifyGreaterThanOrEqual(r, 0.)
end
end


function test_process_priority(tc, B_get_process_priority)
r = stdlib.get_process_priority(B_get_process_priority);
tc.verifyNotEmpty(r)
end


function test_os_version(tc, B_os_version)
[os, ver] = stdlib.os_version(B_os_version);

tc.verifyClass(os, 'char')
tc.verifyClass(ver, 'char')
tc.verifyGreaterThan(strlength(os), 0, "expected non-empty os")
tc.verifyGreaterThan(strlength(ver), 0, "expected non-empty version")
end


function test_checkRAM(tc)
tc.verifyTrue(stdlib.checkRAM(1, "double"))
end


function test_hostname(tc, B_hostname)
[h, b] = stdlib.hostname(B_hostname);
tc.assertEqual(char(b), B_hostname)
tc.verifyClass(h, 'char')
tc.verifyGreaterThan(strlength(h), 0)
end


function test_get_uid(tc, B_get_uid)
[u, b] = stdlib.get_uid(B_get_uid);
tc.assertEqual(char(b), B_get_uid)
if ispc()
  tc.verifyClass(u, 'char')
  tc.verifyGreaterThan(strlength(u), 0)
else
  tc.verifyNotEmpty(u)
end
end


function test_username(tc, B_username)
[u, b] = stdlib.get_username(B_username);
tc.assertEqual(char(b), B_username)
tc.verifyClass(u, 'char')
tc.verifyGreaterThan(strlength(u), 0)
end


function test_cpu_arch(tc)
arch = stdlib.cpu_arch();
tc.verifyClass(arch, 'char')
tc.verifyGreaterThan(strlength(arch), 0, "CPU architecture should not be empty")
end

function test_ram_total(tc, B_ram_total)
[t, b] = stdlib.ram_total(B_ram_total);
tc.assertEqual(char(b), B_ram_total)
tc.verifyClass(t, 'uint64')
tc.verifyGreaterThan(t, 0)
end


function test_ram_free(tc, B_ram_free)
% don't verify less than or equal to total due to shaky system measurements'
[f, b] = stdlib.ram_free(B_ram_free);
tc.assertEqual(char(b), B_ram_free)

tc.verifyClass(f, 'uint64')
if B_ram_free == "python" && ~stdlib.python.has_psutil()
  tc.verifyEmpty(f)
else
  tc.verifyGreaterThan(f, 0)
end
end

end
end
