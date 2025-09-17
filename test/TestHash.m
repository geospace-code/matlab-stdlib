classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017b', 'impure'}) ...
    TestHash < matlab.unittest.TestCase

properties
file = 'hello.txt'
empty = 'empty.txt'
end

properties (TestParameter)
Pe = {{'md5', 'd41d8cd98f00b204e9800998ecf8427e'}, ...
    {'sha-256', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'}}

Ph = {{'md5', '5d41402abc4b2a76b9719d911017c592'}, ...
      {'sha-256', '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824'}}
backend = {'java', 'dotnet', 'sys'}
end


methods(TestClassSetup)
function create_file(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());

fid = fopen(tc.file, "w");
tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");
fclose(fid);
tc.assumeTrue(isfile(tc.file))
tc.assertEqual(stdlib.file_size(tc.file), 5)

fid = fopen(tc.empty, "w");
tc.assumeGreaterThan(fid, 0);
fclose(fid);
tc.assumeTrue(isfile(tc.empty))
tc.assertEqual(stdlib.file_size(tc.empty), 0)
end
end


methods (Test)

function test_hash_text(tc, Ph, backend)

[r, b] = stdlib.file_checksum(tc.file, Ph{1}, backend);
tc.assertEqual(char(b), backend)
tc.verifyClass(r, 'char')

if ismember(backend, stdlib.Backend().select('file_checksum'))
  tc.verifyEqual(r, Ph{2})
else
  tc.assertEmpty(r)
end
end


function test_hash_empty(tc, Pe, backend)

r = stdlib.file_checksum(tc.empty, Pe{1}, backend);
tc.verifyClass(r, 'char')

if ismember(backend, stdlib.Backend().select('file_checksum'))
  if ispc() && backend == "sys"
    tc.verifyEmpty(r)
  else
    tc.verifyEqual(r, Pe{2})
  end
else
  tc.assertEmpty(r)
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
