classdef TestFileImpure < matlab.unittest.TestCase

properties (ClassSetupParameter)
  classToTest = {"TestFileImpure"};
end

properties(TestParameter)
p_exists = {{pwd(), true}, {mfilename("fullpath") + ".m", true}, {tempname, false}}
% on CI matlabroot can be writable!
in_is_write = {pwd(), "not-exists"};
ref_is_write = {true, false}
p_expand
p_same = {...
{"","", false}, ...
{tempname, tempname, false}, ...
{"..", "./..", true}, ...
{"..", pwd() + "/..", true}}
end

properties
tobj
end


methods (TestParameterDefinition, Static)

function p_expand = init_expand(classToTest) %#ok<INUSD>
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
addpath(top)
p_expand = {{"", ""}, {"~abc", "~abc"}, {"~", stdlib.homedir()}, {"~/foo", stdlib.homedir() + "/foo"}};
end
end


methods(TestClassSetup)

function classSetup(tc, classToTest)
constructor = str2func(classToTest);
tc.tobj = constructor();
end

function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end

end

methods (Test, ParameterCombination = 'sequential')

function test_exists(tc, p_exists)
tc.verifyEqual(stdlib.exists(p_exists{1}), p_exists{2})
end


function test_is_readable(tc, p_exists)
tc.verifyEqual(stdlib.is_readable(p_exists{1}), p_exists{2})
end


function test_is_writable(tc, in_is_write, ref_is_write)
tc.verifyEqual(stdlib.is_writable(in_is_write), ref_is_write)
end


function test_expanduser(tc, p_expand)
tc.verifyEqual(stdlib.expanduser(p_expand{1}), p_expand{2})
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


function test_getpid(tc)
pid = stdlib.getpid();
tc.verifyGreaterThan(pid, 0, "expected positive PID")
end

function test_get_permissions(tc)
import matlab.unittest.constraints.StartsWithSubstring
p = stdlib.get_permissions(".");
tc.verifyThat(p, StartsWithSubstring("r"))
end

function test_handle2filename(tc)
tc.verifyEqual(stdlib.handle2filename(0), '"' + "stdin" + '"')
tc.verifyEqual(stdlib.handle2filename(1), '"' + "stdout" + '"')
tc.verifyEqual(stdlib.handle2filename(2), '"' + "stderr" + '"')
tc.verifyEmpty(stdlib.handle2filename(fopen(tempname)))
end

end

end
