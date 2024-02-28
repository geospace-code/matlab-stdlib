classdef TestWindowsCOM < matlab.unittest.TestCase

methods (Test)

function test_shortname(tc)

tc.assumeTrue(ispc, "Windows only")

progdir = stdlib.fileio.posix(getenv("PROGRAMFILES"));
tc.assumeTrue(isfolder(progdir), "Env:ProgramFiles not defined")

short = stdlib.fileio.windows_shortname(progdir);

tc.verifyTrue(contains(short, "PROGRA~1"), short + " did not contain PROGRA~1")

tc.verifyEqual(stdlib.canonical(short), progdir)

end

end

end
