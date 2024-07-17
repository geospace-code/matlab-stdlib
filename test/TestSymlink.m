classdef TestSymlink < matlab.unittest.TestCase

properties
TestData
end

methods(TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end

function setup_symlink(tc)
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.fixtures.TemporaryFolderFixture

fixture = tc.applyFixture(TemporaryFolderFixture);
td = fixture.Folder;
tc.applyFixture(CurrentFolderFixture(td))

tc.TestData.link = stdlib.join(td, "my.lnk");

tc.TestData.this = mfilename("fullpath") + ".m";

tc.assumeTrue(stdlib.create_symlink(tc.TestData.this, tc.TestData.link), ...
    "failed to create test link " + tc.TestData.link)

end

end

methods (Test)

function test_is_symlink(tc)

tc.verifyFalse(stdlib.is_symlink("not-exist"))

tc.verifyTrue(stdlib.is_symlink(tc.TestData.link))
tc.verifyFalse(stdlib.is_symlink(tc.TestData.this))

end


function test_read_symlink(tc)
import matlab.unittest.constraints.IsOfClass

tc.verifyEmpty(stdlib.read_symlink("not-exist"))
tc.verifyEmpty(stdlib.read_symlink(tc.TestData.this))

t = stdlib.read_symlink(tc.TestData.link);
tc.verifyNotEmpty(t)
tc.verifyThat(t, IsOfClass('string'))
tc.verifyTrue(stdlib.samepath(tc.TestData.this, t))

end


function test_create_symlink(tc)

tc.verifyFalse(stdlib.create_symlink(tc.TestData.this, tc.TestData.link))
tc.verifyTrue(stdlib.create_symlink(tc.TestData.this, "another.lnk"))
tc.verifyTrue(stdlib.is_symlink("another.lnk"))

end


end

end
