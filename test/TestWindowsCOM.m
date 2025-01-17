classdef TestWindowsCOM < matlab.unittest.TestCase

properties (TestParameter)
Pn = {"", "file:///"}
Pmr = {string(matlabroot), stdlib.posix(matlabroot)}
end

methods (Test)

function test_not(tc, Pn)
tc.verifyEqual(stdlib.windows_shortname(Pn), "")
end

function test_short_folder(tc)
import matlab.unittest.constraints.IsFolder

progdir = stdlib.posix(getenv("PROGRAMFILES"));
tc.assumeThat(progdir, IsFolder, "$Env:PROGRAMFILES is not a directory")

short = stdlib.windows_shortname(progdir);

if ispc
  tc.verifySubstring(short, "PROGRA~1")
  tc.verifyEqual(stdlib.canonical(short), progdir)
else
  tc.verifyEqual(short, progdir)
end

end


function test_short_file(tc, Pmr)
import matlab.unittest.constraints.IsFile

s = stdlib.windows_shortname(Pmr);

if ispc
  if contains(Pmr, " ")
    tc.verifySubstring(s, "~")
  end
  tc.verifyEqual(stdlib.canonical(s), stdlib.posix(Pmr), "shortname didn't resolve same as canonical")
else
  tc.verifyEqual(s, Pmr)
end

end

end

end
