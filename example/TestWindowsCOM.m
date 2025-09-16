classdef TestWindowsCOM < matlab.unittest.TestCase

properties (TestParameter)
Pn = {{"", ""}}
Pmr = {matlabroot, stdlib.posix(matlabroot)}
end

methods (Test)

function test_not(tc, Pn)
tc.verifyEqual(windows_shortname(Pn{1}), Pn{2})
end

function test_short_folder(tc)

progdir = getenv('PROGRAMFILES');
if ispc()
  tc.assertThat(progdir, matlab.unittest.constraints.IsFolder, "$Env:PROGRAMFILES is not a directory")
end

short = windows_shortname(progdir);

if ispc
  tc.verifySubstring(short, "PROGRA~1")
  tc.verifyTrue(stdlib.samepath(short, progdir))
else
  tc.verifyEqual(strlength(short), 0)
end

end


function test_short_file(tc, Pmr)

s = windows_shortname(Pmr);

if ispc
  if contains(Pmr, " ")
    tc.verifySubstring(s, "~")
  end

  tc.verifyLessThanOrEqual(strlength(s), strlength(Pmr))
end

tc.verifyTrue(stdlib.samepath(s, Pmr))

end

end

end
