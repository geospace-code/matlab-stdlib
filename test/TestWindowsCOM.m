classdef TestWindowsCOM < matlab.unittest.TestCase

properties (TestParameter)
Pn = {""}
Pmr = {matlabroot, stdlib.posix(matlabroot)}
end

methods (Test)

function test_not(tc, Pn)
tc.verifyEqual(stdlib.windows_shortname(Pn), "")
end

function test_short_folder(tc)
import matlab.unittest.constraints.IsFolder

progdir = stdlib.posix(getenv("PROGRAMFILES"));
if ispc()
  tc.assertThat(progdir, IsFolder, "$Env:PROGRAMFILES is not a directory")
end

short = stdlib.windows_shortname(progdir);

if ispc
  tc.verifySubstring(short, "PROGRA~1")
  tc.verifyTrue(stdlib.samepath(short, string(progdir)))
else
  tc.verifyEqual(strlength(short), 0)
end

end


function test_short_file(tc, Pmr)
import matlab.unittest.constraints.IsFile

s = stdlib.windows_shortname(Pmr);

if ispc
  if contains(Pmr, " ")
    tc.verifySubstring(s, "~")
  end
  tc.verifyEqual(stdlib.canonical(s), string(stdlib.posix(Pmr)), "shortname didn't resolve same as canonical")
else
  tc.verifyEqual(s, string(Pmr))
end

end

end

end
