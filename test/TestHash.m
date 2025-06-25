classdef TestHash < matlab.unittest.TestCase

properties (TestParameter)
Ph = {{'md5', '5d41402abc4b2a76b9719d911017c592'}, ...
      {'sha-256', '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'}}
end


methods (Test, TestTags="java")


function test_hash_text(tc, Ph)

td = tc.createTemporaryFolder();

fn = td + "/hello";
fid = fopen(fn, "w");

tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");
fclose(fid);

tc.assumeThat(fn, matlab.unittest.constraints.IsFile)

tc.verifyEqual(stdlib.file_checksum(fn, Ph{1}), Ph{2})

end


end

end
