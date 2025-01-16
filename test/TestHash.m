classdef TestHash < matlab.unittest.TestCase

properties (TestParameter)
type = {'sha256', 'md5'}
hash = {"36c1bbbdfd8d04ef546ffb15b9c0a65767fd1fe9a6135a257847e3a51fb1426c", "d58cfb32e075781ba59082a8b18287f9"}
Pe = {"file:///", "", "/"}
end

methods(TestClassSetup)
function java_required(tc)
tc.assumeTrue(stdlib.has_java())
end
end


methods (Test, ParameterCombination = 'sequential')

function test_extract(tc)
import matlab.unittest.constraints.IsFile

r = fileparts(mfilename('fullpath'));
fn = stdlib.posix(r) + "/hello.tar.zst";

tc.assumeThat(fn, IsFile)

tc.assumeNotEmpty(stdlib.which("cmake"), "CMake not available")

td = stdlib.posix(tc.createTemporaryFolder());

stdlib.extract_zstd(fn, td)
tc.verifyThat(td + "/test/hello.txt", IsFile)

end


function test_hash(tc, type, hash)

r = fileparts(mfilename('fullpath'));
fn = fullfile(r, "hello.tar.zst");

switch type
case 'sha256', h = stdlib.sha256sum(fn);
case 'md5', h = stdlib.md5sum(fn);
end

tc.verifyEqual(h, hash)

end


function test_hash_text(tc)
import matlab.unittest.constraints.IsFile

td = stdlib.posix(tc.createTemporaryFolder());

fn = td + "/hello";
fid = fopen(fn, "w");
tc.addTeardown(@fclose, fid)

tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");

tc.assumeThat(fn, IsFile)

tc.verifyEqual(stdlib.file_checksum(fn, "md5"), "5d41402abc4b2a76b9719d911017c592")
tc.verifyEqual(stdlib.file_checksum(fn, "sha256"), "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824")

end


function test_hash_empty(tc, Pe)
tc.verifyEmpty(stdlib.file_checksum(Pe, "sha256"))
end

end

end
