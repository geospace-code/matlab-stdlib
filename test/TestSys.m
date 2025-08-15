classdef (TestTags = {'R2019b', 'impure'}) ...
    TestSys < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
cwd = fileparts(mfilename('fullpath'))
root
end

properties (TestParameter)
backend_djn = init_backend({'java', 'dotnet', 'native'})
backend_jps = init_backend({'sys', 'java', 'python'})
backend_djps = init_backend({'java', 'python', 'dotnet', 'sys'})
end

methods(TestClassSetup)
function setupPaths(tc)
tc.root = fileparts(tc.cwd);
pkg_path(tc)
end
end


methods (Test)

function test_has_ext_lang(tc)

tc.verifyClass(stdlib.isoctave(), 'logical')
tc.verifyClass(stdlib.has_dotnet(), 'logical')
tc.verifyClass(stdlib.has_java(), 'logical')
tc.verifyClass(stdlib.has_python(), 'logical')

end

function test_toolbox_used(tc)
[mathworksUsed, userFun] = stdlib.toolbox_used(fullfile(tc.root, "+stdlib"));
Nlicense = length(mathworksUsed);
tc.verifyGreaterThanOrEqual(Nlicense, 1)
tc.verifyTrue(any(ismember(mathworksUsed, "MATLAB")))
tc.verifyGreaterThan(length(userFun), 200) % we have over 200 stdlib functions

% don't use paid toolboxes without checking they exist, otherwise this function fails
[mathworksUsed, userFun] = stdlib.toolbox_used(["which", "disp"]);
tc.verifyEqual(userFun, string.empty)
tc.verifyEqual(length(mathworksUsed), 1)
end

function test_all_toolboxes(tc)
tc.assumeTrue(stdlib.has_java())
tbx = stdlib.allToolboxes();
tc.verifyClass(tbx, "table")
end

function test_platform_tell(tc)
r = stdlib.platform_tell();
tc.verifyClass(r, 'char')
tc.verifyNotEmpty(r)
end


function test_is_cygwin(tc)
tc.verifyFalse(stdlib.is_cygwin())
end

function test_is_admin(tc, backend_djps)

i = stdlib.is_admin(backend_djps);
tc.verifyClass(i, "logical")

if (backend_djps == "java" && ispc()) || ...
   (backend_djps == "dotnet" && isunix()) || ...
   (backend_djps == "python" && ispc() && stdlib.matlabOlderThan('R2024a'))
  tc.verifyEmpty(i)
else
  tc.verifyNotEmpty(i)
end
end


function test_get_pid(tc)
pid = stdlib.get_pid();

tc.verifyGreaterThan(pid, 0)
tc.verifyClass(pid, 'uint64')
end


function test_cpu_load(tc, backend_jps)
r = stdlib.cpu_load(backend_jps);
if ispc() && backend_jps == "python"
  tc.verifyEmpty(r)
else
  tc.verifyGreaterThanOrEqual(r, 0.)
end
end


function test_get_shell(tc)
tc.assumeFalse(tc.CI, "get_shell is not tested in CI due to platform differences")
tc.verifyClass(stdlib.get_shell(), 'char')
tc.verifyGreaterThan(strlength(stdlib.get_shell()), 0)
end

function test_is_interactive(tc)
if tc.CI
  tc.verifyFalse(stdlib.isinteractive())
else
  tc.verifyClass(stdlib.isinteractive(), 'logical')
end
end

function test_is_rosetta(tc)
if ismac()
  tc.verifyClass(stdlib.is_rosetta(), 'logical')
else
  tc.verifyFalse(stdlib.is_rosetta(), 'is_rosetta should be false on non-macOS systems')
end
end

function test_is_wsl(tc)
if isunix() && ~ismac()
  tc.verifyGreaterThanOrEqual(stdlib.is_wsl(), 0)
else
  tc.verifyEqual(stdlib.is_wsl(), 0)
end
end

function test_os_version(tc, backend_djps)
[os, ver] = stdlib.os_version(backend_djps);

tc.verifyClass(os, 'char')
tc.verifyClass(ver, 'char')
tc.verifyGreaterThan(strlength(os), 0, "expected non-empty os")
tc.verifyGreaterThan(strlength(ver), 0, "expected non-empty version")
end

function test_cpu_count(tc)
tc.verifyGreaterThan(stdlib.cpu_count(), 0)
end

function test_checkRAM(tc)
tc.verifyTrue(stdlib.checkRAM(1, "double"))
end

function test_is_parallel(tc)
ip = stdlib.is_parallel_worker();
tc.verifyNotEmpty(ip)
tc.verifyClass(ip, 'logical')
end

function test_hostname(tc, backend_djps)
h = stdlib.hostname(backend_djps);
tc.verifyClass(h, 'char')
tc.verifyGreaterThan(strlength(h), 0)
end

function test_username(tc, backend_djps)
u = stdlib.get_username(backend_djps);
tc.verifyClass(u, 'char')
tc.verifyGreaterThan(strlength(u), 0)
end


function test_xcode_version(tc)
if ismac()
  tc.verifyNotEmpty(stdlib.xcode_version())
else
  tc.verifyEmpty(stdlib.xcode_version())
end
end


function test_cpu_arch(tc, backend_djn)
arch = stdlib.cpu_arch(backend_djn);
tc.verifyClass(arch, 'char')
tc.verifyGreaterThan(strlength(arch), 0, "CPU architecture should not be empty")
end

function test_ram_total(tc, backend_djps)
t = stdlib.ram_total(backend_djps);

tc.verifyClass(t, 'uint64')
if (backend_djps == "python" && ~stdlib.python.has_psutil()) || ...
    (backend_djps == "dotnet" && stdlib.dotnet_api() < 6)
  tc.verifyEmpty(t)
else
  tc.verifyGreaterThan(t, 0)
end
end


function test_ram_free(tc, backend_jps)
% don't verify less than or equal total due to shaky system measurements'
f = stdlib.ram_free(backend_jps);

tc.verifyClass(f, 'uint64')
if backend_jps == "python" && ~stdlib.python.has_psutil()
  tc.verifyEmpty(f)
else
  tc.verifyGreaterThan(f, 0)
end
end

end
end
