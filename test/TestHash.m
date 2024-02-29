classdef TestHash < matlab.unittest.TestCase

methods(TestClassSetup)
function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end
end

methods (Test)

function test_extract(tc)
import matlab.unittest.constraints.IsFile
import matlab.unittest.fixtures.TemporaryFolderFixture

fixture = tc.applyFixture(TemporaryFolderFixture);
tmpDir = fixture.Folder;

r = fileparts(mfilename('fullpath'));
fn = fullfile(r, "hello.tar.zst");

tc.assumeThat(fn, IsFile)

tc.assumeNotEmpty(stdlib.which("cmake"), "CMake not available")

stdlib.extract_zstd(fn, tmpDir)
tc.verifyThat(fullfile(tmpDir, "test/hello.txt"), IsFile)

end

end

end