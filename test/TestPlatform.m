classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'R2019b', 'impure'}) ...
    TestPlatform < matlab.unittest.TestCase

properties
CI = getenv("CI") == "true" || getenv("GITHUB_ACTIONS") == "true"
end


methods (Test)

function test_toolbox_used(tc)
r = fullfile(fileparts(fileparts(mfilename('fullpath'))), '+stdlib');
[mathworksUsed, userFun] = stdlib.toolbox_used(r);
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


function test_get_pid(tc)
pid = stdlib.get_pid();

tc.verifyGreaterThan(pid, 0)
tc.verifyClass(pid, 'uint64')
end


function test_has_ext_lang(tc)
tc.verifyClass(stdlib.isoctave(), 'logical')
tc.verifyClass(stdlib.has_dotnet(), 'logical')
tc.verifyClass(stdlib.has_java(), 'logical')
tc.verifyClass(stdlib.has_python(), 'logical')
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


function test_xcode_version(tc)
if ismac()
  tc.verifyNotEmpty(stdlib.xcode_version())
else
  tc.verifyEmpty(stdlib.xcode_version())
end
end


function test_is_parallel(tc)
ip = stdlib.is_parallel_worker();
tc.verifyNotEmpty(ip)
tc.verifyClass(ip, 'logical')
end


function test_cpu_count(tc)
tc.verifyGreaterThan(stdlib.cpu_count(), 0)
end



end

end