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
fn = stdlib.join(r, "hello.tar.zst");

tc.assumeThat(fn, IsFile)

tc.assumeNotEmpty(stdlib.which("cmake"), "CMake not available")

stdlib.extract_zstd(fn, tmpDir)
tc.verifyThat(stdlib.join(tmpDir, "test/hello.txt"), IsFile)

end

function test_sha256(tc)

r = fileparts(mfilename('fullpath'));
fn = stdlib.join(r, "hello.tar.zst");

tc.verifyEqual(stdlib.sha256sum(fn), "36c1bbbdfd8d04ef546ffb15b9c0a65767fd1fe9a6135a257847e3a51fb1426c")

end

function test_md5sum(tc)

r = fileparts(mfilename('fullpath'));
fn = stdlib.join(r, "hello.tar.zst");

tc.verifyEqual(stdlib.md5sum(fn), "d58cfb32e075781ba59082a8b18287f9")

end

end

end
