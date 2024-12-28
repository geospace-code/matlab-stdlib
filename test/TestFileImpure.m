classdef TestFileImpure < matlab.unittest.TestCase

properties(TestParameter)
use_java = num2cell(unique([stdlib.has_java(), false]))

p_exists = {{pwd(), true}, {mfilename("fullpath") + ".m", true}, {"TestFileImpure.m", true} {tempname, false}}
% on CI matlabroot can be writable!

p_is_writable = {{pwd(), true}, {"not-exists", false}};

p_expand = {{"", ""}, {"~abc", "~abc"}, {"~", stdlib.homedir()}, {"~/c", stdlib.homedir() + "/c"}, {'~/////c', stdlib.homedir() + "/c"}};

p_same = {...
{"","", false}, ...
{tempname, tempname, false}, ...
{"..", "./..", true}, ...
{"..", pwd() + "/..", true}}

ph = {{0, '"stdin"'}, {1, '"stdout"'}, {2, '"stderr"'}, {fopen(tempname), ""}}
end


methods (Test)

function test_exists(tc, p_exists, use_java)
ok = stdlib.exists(p_exists{1}, use_java);
tc.verifyEqual(ok, p_exists{2})
end

function test_file_size(tc, use_java)
s = stdlib.file_size(mfilename("fullpath") + ".m", use_java);
tc.verifyGreaterThan(s, 0)
end


function test_is_readable(tc, p_exists, use_java)
ok = stdlib.is_readable(p_exists{1}, use_java);
tc.verifyEqual(ok, p_exists{2})
end


function test_is_writable(tc, p_is_writable, use_java)
ok = stdlib.is_writable(p_is_writable{1}, use_java);
tc.verifyEqual(ok, p_is_writable{2})
end


function test_expanduser(tc, p_expand, use_java)
tc.verifyEqual(stdlib.expanduser(p_expand{1}), p_expand{2}, use_java)
end


function test_null_file(tc)
import matlab.unittest.constraints.IsFile
tc.assumeFalse(ispc)
tc.verifyThat(stdlib.null_file, IsFile)
end


function test_makedir(tc)
import matlab.unittest.constraints.IsFolder
d = tempname;
stdlib.makedir(d)
tc.assertThat(d, IsFolder)
end

%%
function test_samepath(tc, p_same)
tc.verifyEqual(stdlib.samepath(p_same{1}, p_same{2}), p_same{3})
end


function test_get_pid(tc)
pid = stdlib.get_pid();
tc.verifyGreaterThan(pid, 0, "expected positive PID")
end

function test_get_permissions(tc)
import matlab.unittest.constraints.StartsWithSubstring
p = stdlib.get_permissions(".");
tc.verifyThat(p, StartsWithSubstring("r"))
end

function test_handle2filename(tc, ph)
tc.verifyEqual(stdlib.handle2filename(ph{1}), string(ph{2}))
end

end

end
