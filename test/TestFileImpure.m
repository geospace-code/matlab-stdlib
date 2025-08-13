classdef (TestTags = {'R2019b', 'impure'}) ...
    TestFileImpure < matlab.unittest.TestCase

properties(TestParameter)
ph = {{0, '"stdin"'}, {1, '"stdout"'}, {2, '"stderr"'}, {fopen(tempname()), ''}}

p_file_size = {mfilename("fullpath") + ".m"}
end


methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end
end


methods (Test)

function test_file_size(tc, p_file_size)
s = stdlib.file_size(p_file_size);
tc.verifyGreaterThan(s, 0)
end

function test_file_size_array(tc)
s = stdlib.file_size([mfilename("fullpath") + ".m", "not-exist", fullfile(fileparts(pwd()), "buildfile.m"), tempname()]);
tc.verifyTrue(all([s(1) > 0, isnan(s(2)), s(3) > 0, isnan(s(4))]))
end


function test_null_file(tc)
if ispc()
  tc.verifyEqual(stdlib.null_file, "NUL")
else
  tc.verifyThat(stdlib.null_file, matlab.unittest.constraints.IsFile)
end
end


function test_makedir(tc)
d = tempname();
stdlib.makedir(d)
tc.verifyThat(d, matlab.unittest.constraints.IsFolder)
rmdir(d)
end


function test_handle2filename(tc, ph)
tc.verifyEqual(stdlib.handle2filename(ph{1}), ph{2})
end

end

end
