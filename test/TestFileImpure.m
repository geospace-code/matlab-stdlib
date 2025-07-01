classdef TestFileImpure < matlab.unittest.TestCase

properties(TestParameter)
p_is_writable = {{pwd(), true}, {"not-exists", false}, {"", false}};

p_same = {...
{"..", "./.."}, ...
{"..", pwd() + "/.."}}

ph = {{0, '"stdin"'}, {1, '"stdout"'}, {2, '"stderr"'}, {fopen(tempname()), ''}}

p_file_size = {mfilename("fullpath") + ".m"}
end


methods (Test, TestTags="impure")

function test_file_size(tc, p_file_size)
s = stdlib.file_size(p_file_size);
tc.verifyGreaterThan(s, 0)
end


function test_is_writable(tc, p_is_writable)
ok = stdlib.is_writable(p_is_writable{1});
tc.verifyEqual(ok, p_is_writable{2})
end


function test_null_file(tc)
import matlab.unittest.constraints.IsFile
tc.assumeFalse(ispc)
tc.verifyThat(stdlib.null_file, IsFile)
end


function test_makedir(tc)
import matlab.unittest.constraints.IsFolder
d = tempname();
stdlib.makedir(d)
tc.assertThat(d, IsFolder)
rmdir(d)
end

%%
function test_samepath(tc, p_same)
tc.verifyTrue(stdlib.samepath(p_same{1}, p_same{2}))
end

function test_samepath_notexist(tc)
tc.verifyFalse(stdlib.samepath("", ""))
t = tempname();
tc.verifyFalse(stdlib.samepath(t, t))
end


function test_get_pid(tc)
pid = stdlib.get_pid();
tc.verifyGreaterThan(pid, 0)
end


function test_handle2filename(tc, ph)
tc.verifyEqual(stdlib.handle2filename(ph{1}), ph{2})
end

end

end
