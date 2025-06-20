classdef TestWindowsCOM < matlab.unittest.TestCase

properties (TestParameter)
Pn = {{"", ""}}
Pmr = {matlabroot, stdlib.posix(matlabroot)}
end

methods (Test)

function test_not(tc, Pn)
tc.verifyEqual(stdlib.windows_shortname(Pn{1}), Pn{2})
end

function test_short_folder(tc)
import matlab.unittest.constraints.IsFolder

progdir = getenv("PROGRAMFILES");
if ispc()
  tc.assertThat(progdir, IsFolder, "$Env:PROGRAMFILES is not a directory")
end

short = stdlib.windows_shortname(progdir);

if ispc
  tc.verifySubstring(short, "PROGRA~1")
  tc.verifyTrue(stdlib.samepath(short, progdir))
else
  tc.verifyEqual(strlength(short), 0)
end

end


function test_short_file(tc, Pmr)

s = stdlib.windows_shortname(Pmr);

if ispc
  if contains(Pmr, " ")
    tc.verifySubstring(s, "~")
  end

  tc.verifyLessThanOrEqual(strlength(s), strlength(Pmr))
end

tc.verifyTrue(stdlib.samepath(s, Pmr),...
  sprintf("mex: %d", stdlib.is_mex_fun("stdlib.windows_shortname")))

end

end

end
