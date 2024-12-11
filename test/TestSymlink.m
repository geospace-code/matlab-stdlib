classdef TestSymlink < matlab.unittest.TestCase

properties
d
end

properties (TestParameter)
p_is_symlink
end


methods(TestClassSetup)
function setup_path(tc)
top = fullfile(fileparts(mfilename("fullpath")), "..");
tc.applyFixture(matlab.unittest.fixtures.PathFixture(top))
end

function setup_symlink(tc)
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.fixtures.TemporaryFolderFixture

fixture = tc.applyFixture(TemporaryFolderFixture);
td = stdlib.posix(fixture.Folder);
tc.applyFixture(CurrentFolderFixture(td))

tc.d.link = td + "/my.lnk";

tc.d.this = stdlib.posix(mfilename("fullpath") + ".m");

tc.assumeTrue(stdlib.create_symlink(tc.d.this, tc.d.link), ...
    "failed to create test link " + tc.d.link)

end
end

methods(TestParameterDefinition, Static)

function p_is_symlink = init_symlink()
p_is_symlink = {{"not-exist", false}, {"my.lnk", true}, {mfilename("fullpath") + ".m", false}};
end

end

methods (Test)

function test_is_symlink(tc, p_is_symlink)
tc.verifyEqual(stdlib.is_symlink(p_is_symlink{1}), p_is_symlink{2})
end


function test_read_symlink(tc)
import matlab.unittest.constraints.IsOfClass

tc.verifyEqual(stdlib.read_symlink("not-exist"), "")
tc.verifyEqual(stdlib.read_symlink(tc.d.this), "")

t = stdlib.read_symlink(tc.d.link);
tc.verifyNotEmpty(t)
tc.verifyThat(t, IsOfClass('string'))
tc.verifyEqual(tc.d.this, t)

end


function test_create_symlink(tc)

tc.verifyFalse(stdlib.create_symlink(tc.d.this, tc.d.link))
tc.verifyTrue(stdlib.create_symlink(tc.d.this, "another.lnk"))
tc.verifyTrue(stdlib.is_symlink("another.lnk"))

end


end

end
