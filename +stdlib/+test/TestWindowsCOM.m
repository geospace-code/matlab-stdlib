classdef TestWindowsCOM < matlab.unittest.TestCase

methods (Test)

function test_shortname(tc)
import matlab.unittest.constraints.IsFolder

tc.assumeTrue(ispc, "Windows only")

progdir = stdlib.fileio.posix(getenv("PROGRAMFILES"));
tc.assumeThat(progdir, IsFolder, "PROGRAMFILES is not a directory")

short = stdlib.fileio.windows_shortname(progdir);

tc.verifySubstring(short, "PROGRA~1")

tc.verifyEqual(stdlib.canonical(short), progdir)

end

end

end
