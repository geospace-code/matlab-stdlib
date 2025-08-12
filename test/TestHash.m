classdef TestHash < matlab.unittest.TestCase

properties
file
end

properties (TestParameter)
Ph = {{'md5', '5d41402abc4b2a76b9719d911017c592'}, ...
      {'sha-256', '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'}}
backend = {'java', 'dotnet', 'sys'}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)
end

function create_file(tc)
td = createTempdir(tc);

tc.file = td + "/hello";
fid = fopen(tc.file, "w");

tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");
fclose(fid);

tc.assertThat(tc.file, matlab.unittest.constraints.IsFile)
end
end


methods (Test, TestTags=["R2019b", "impure"])

function test_hash_text(tc, Ph, backend)
try
  tc.verifyEqual(stdlib.file_checksum(tc.file, Ph{1}, backend), Ph{2})
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end

end

function test_has_convenience(tc, Ph)
switch Ph{1}
  case 'md5', tc.verifyEqual(stdlib.md5sum(tc.file), Ph{2})
  case 'sha-256', tc.verifyEqual(stdlib.sha256sum(tc.file), Ph{2})
end
end

end

end
