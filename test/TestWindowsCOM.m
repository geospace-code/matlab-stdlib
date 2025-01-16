classdef TestWindowsCOM < matlab.unittest.TestCase

properties (TestParameter)
Pn = {"", "not-exist", "file:///"}
Pmr = {matlabroot, stdlib.posix(matlabroot)}
end

methods (Test)

function test_not(tc, Pn)
tc.verifyEqual(stdlib.windows_shortname(Pn), "")
end

function test_short_folder(tc)
import matlab.unittest.constraints.IsFolder

progdir = stdlib.posix(getenv("PROGRAMFILES"));
if ispc
tc.assumeThat(progdir, IsFolder, "$Env:PROGRAMFILES is not a directory")
end

short = stdlib.windows_shortname(progdir);

if ispc
  tc.verifySubstring(short, "PROGRA~1")
  tc.verifyEqual(stdlib.canonical(short), progdir)
else
  tc.verifyEqual(short, "")
end

end


function test_short_file(tc, Pmr)
import matlab.unittest.constraints.IsFile

if ispc
tc.assumeSubstring(Pmr, " ", "name won't shorten if it doesn't have a space")
end

s = stdlib.windows_shortname(Pmr);

if ispc
  if contains(Pmr, " ")
    tc.verifySubstring(s, "~")
  end
  tc.verifyEqual(stdlib.canonical(s), stdlib.posix(Pmr), "shortname didn't resolve same as canonical")
else
  tc.verifyEqual(s, "")
end

end

end

end
