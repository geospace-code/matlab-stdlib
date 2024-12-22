classdef TestWindowsCOM < matlab.unittest.TestCase

methods (TestClassSetup)
function setup_path(tc)
top = fullfile(fileparts(mfilename("fullpath")), "..");
tc.applyFixture(matlab.unittest.fixtures.PathFixture(top))
end
end


methods (Test)

function test_not(tc)
tc.verifyEmpty(stdlib.windows_shortname("not-exist"))

end

function test_short_folder(tc)
import matlab.unittest.constraints.IsFolder

tc.assumeTrue(ispc, "Windows only")

progdir = stdlib.posix(getenv("PROGRAMFILES"));
tc.assumeThat(progdir, IsFolder, "env:PROGRAMFILES is not a directory")

short = stdlib.windows_shortname(progdir);

tc.verifySubstring(short, "PROGRA~1")

tc.verifyEqual(stdlib.canonical(short), progdir)

end


function test_short_file(tc)
import matlab.unittest.constraints.IsFile

tc.assumeTrue(ispc, "Windows only")
p = matlabroot;
tc.assumeSubstring(p, " ", "name won't shorten if it doesn't have a space")

for d = [p, stdlib.posix(p)]
  s = stdlib.windows_shortname(d);

  tc.verifySubstring(s, "~")
end

tc.verifyEqual(stdlib.canonical(s), stdlib.posix(p), "shortname didn't resolve same as canonical")

end

end

end
