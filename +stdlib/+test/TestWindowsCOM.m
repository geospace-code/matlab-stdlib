classdef TestWindowsCOM < matlab.unittest.TestCase

methods (Test)

function test_shortname(tc)

tc.assumeTrue(ispc, "Windows only")

test_file = string(fullfile(getenv("LocalAppData"), 'Microsoft\WindowsApps\notepad.exe'));
tc.assumeTrue(isfile(test_file))

short = stdlib.fileio.windows_shortname(test_file);

tc.verifyTrue(endsWith(short, 'notepad.exe'), "Short name should end with 'notepad.exe'")
tc.verifyTrue(contains(short, "MICROS~1"))

tc.verifyEqual(stdlib.absolute_path(short), test_file)

end

end

end
