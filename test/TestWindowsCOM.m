classdef TestWindowsCOM < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end
end


methods (Test)

function test_not(tc)
tc.verifyEqual(stdlib.fileio.windows_shortname("not-exist"), "")

end

function test_short_folder(tc)
import matlab.unittest.constraints.IsFolder

tc.assumeTrue(ispc, "Windows only")

progdir = getenv("PROGRAMFILES");
tc.assumeThat(progdir, IsFolder, "PROGRAMFILES is not a directory")

short = stdlib.fileio.windows_shortname(progdir);

tc.verifySubstring(short, "PROGRA~1")

tc.verifyEqual(stdlib.canonical(short), stdlib.posix(progdir))

end


function test_short_file(tc)
import matlab.unittest.constraints.IsFile

tc.assumeTrue(ispc, "Windows only")

file = fullfile(matlabroot, "VersionInfo.xml");
tc.assumeThat(file, IsFile, "VersionInfo.xml missing")

short = stdlib.fileio.windows_shortname(file);

tc.verifySubstring(short, "VERSIO~1.XML")

tc.verifyEqual(stdlib.canonical(short), stdlib.posix(file))

end

end

end
