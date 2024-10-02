classdef TestFileImpure < matlab.unittest.TestCase

properties (ClassSetupParameter)
  classToTest = {"TestFileImpure"};
end

properties(TestParameter)
in_exists = {pwd, mfilename("fullpath") + ".m", "not-exists"}
ref_exists = {true, true, false}
% on CI matlabroot can be writable!
in_is_write = {pwd, "not-exists"};
ref_is_write = {true, false}
in_expand = {"", "~abc", "~", "~/foo"}
ref_expand
in_same = {"", tempname, "..", ".."}
other_same = {"", tempname, "./..", fullfile(pwd, "..")}
ref_same = {false, false, true, true}
end

properties
tobj
end


methods (TestParameterDefinition, Static)

function ref_expand = init_expand(classToTest) %#ok<INUSD>
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
addpath(top)

ref_expand = {"", "~abc", stdlib.homedir, stdlib.join(stdlib.homedir, "foo")};
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

function test_exists(tc, in_exists, ref_exists)
tc.verifyEqual(stdlib.exists(in_exists), ref_exists)
end


function test_is_readable(tc, in_exists, ref_exists)
tc.verifyEqual(stdlib.is_readable(in_exists), ref_exists)
end


function test_is_writable(tc, in_is_write, ref_is_write)
tc.verifyEqual(stdlib.is_writable(in_is_write), ref_is_write)
end


function test_expanduser(tc, in_expand, ref_expand)
tc.verifyEqual(stdlib.expanduser(in_expand), ref_expand)
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
function test_samepath(tc, in_same, other_same, ref_same)
tc.verifyEqual(stdlib.samepath(in_same, other_same), ref_same)
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
