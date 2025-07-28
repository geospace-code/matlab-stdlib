classdef TestHash < matlab.unittest.TestCase

properties
td
end

properties (TestParameter)
Ph = {{'md5', '5d41402abc4b2a76b9719d911017c592'}, ...
      {'sha-256', '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'}}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end


methods(TestMethodSetup)
function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
end
end

methods(TestMethodTeardown)
function remove_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  [s, m, i] = rmdir(tc.td, 's');
  if ~s, warning(i, "Failed to remove temporary directory %s: %s", tc.td, m); end
end
end
end

methods (Test)

function test_hash_text(tc, Ph)
tc.assumeTrue(stdlib.has_dotnet() || stdlib.has_java())

fn = tc.td + "/hello";
fid = fopen(fn, "w");

tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");
fclose(fid);

tc.assertThat(fn, matlab.unittest.constraints.IsFile)

tc.verifyEqual(stdlib.file_checksum(fn, Ph{1}), Ph{2})

switch Ph{1}
  case 'md5', tc.verifyEqual(stdlib.md5sum(fn), Ph{2})
  case 'sha-256', tc.verifyEqual(stdlib.sha256sum(fn), Ph{2})
end

end

end

end
