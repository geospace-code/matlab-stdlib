classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'R2021a', 'symlink', 'impure'}) ...
    TestSymlink < matlab.unittest.TestCase

properties
target
link
end

properties (TestParameter)
p = {{"not-exist", false}, ...
    {mfilename("fullpath") + ".m", false}, ...
    {"", false}};
Pre = {'', "", tempname()}
B_create_symlink
B_read_symlink
B_is_symlink
end


methods (TestParameterDefinition, Static)
function [B_create_symlink, B_read_symlink, B_is_symlink] = setupBackends()
B_create_symlink = init_backend("create_symlink");
B_read_symlink = init_backend("read_symlink");
B_is_symlink = init_backend("is_symlink");
end
end


methods(TestMethodSetup)
% needs to be per-method because multiple functions are used to make the same files

function setup_symlink(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())

tc.link = fullfile(pwd(), 'my.lnk');

tc.target = strcat(mfilename("fullpath"), '.m');

tc.assumeTrue(stdlib.create_symlink(tc.target, tc.link), ...
    "failed to create test link " + tc.link)
end
end



methods (Test)

function test_is_symlink(tc, p, B_is_symlink)
tc.verifyTrue(stdlib.is_symlink(tc.link, B_is_symlink), "failed to detect own link")
tc.verifyEqual(stdlib.is_symlink(p{1}, B_is_symlink), p{2}, p{1})
end

function test_is_symlink_array(tc, B_is_symlink)
r = stdlib.is_symlink([tc.link, mfilename() + ".m"], B_is_symlink);
tc.verifyEqual(r, [true, false], "failed to detect own link")
end


function test_read_symlink_empty(tc, Pre, B_read_symlink)
tc.verifyEqual(stdlib.read_symlink(Pre, B_read_symlink), "")
end


function test_read_symlink(tc, B_read_symlink)
r = stdlib.read_symlink(tc.link, B_read_symlink);
tc.verifyClass(r, 'string')
tc.verifyEqual(r, string(tc.target))
end


function test_read_symlink_array(tc, B_read_symlink)
r = stdlib.read_symlink([tc.link, mfilename() + ".m"], B_read_symlink);
exp = [tc.target, ""];
tc.verifyClass(r, 'string')
tc.verifyEqual(r, exp, "failed to detect own link")
end


function test_create_symlink(tc, B_create_symlink)
tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture(["MATLAB:io:filesystem:symlink:TargetNotFound","MATLAB:io:filesystem:symlink:FileExists"]))

ano = fullfile(pwd(), 'another.lnk');

h = @stdlib.create_symlink;

tc.verifyFalse(h('', tempname(), B_create_symlink))
tc.verifyFalse(h(tc.target, tc.link, B_create_symlink), "should fail for existing symlink")

exp = true;

tc.assertThat(ano, ~matlab.unittest.constraints.IsFile)
tc.assertFalse(stdlib.is_symlink(ano))

tc.verifyEqual(h(tc.target, ano, B_create_symlink), exp)
end

end
end
