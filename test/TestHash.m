classdef TestHash < matlab.unittest.TestCase

properties (TestParameter)
Ph = {{"md5", "5d41402abc4b2a76b9719d911017c592"}, {"sha-256", "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"}}
Pe = {"", "/"}
end

methods(TestClassSetup)
function java_required(tc)
tc.assumeTrue(stdlib.has_java())
end
end


methods (Test)


function test_hash_text(tc, Ph)
tc.assumeFalse(isMATLABReleaseOlderThan("R2022a"))

td = tc.createTemporaryFolder();

fn = td + "/hello";
fid = fopen(fn, "w");

tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");
fclose(fid);

tc.assumeThat(fn, matlab.unittest.constraints.IsFile)

tc.verifyEqual(stdlib.file_checksum(fn, Ph{1}), Ph{2})

end


function test_hash_empty(tc, Pe)
tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture("stdlib:file_checksum:ioerror"))

tc.verifyEmpty(stdlib.file_checksum(Pe, "sha256"))
end

end

end
