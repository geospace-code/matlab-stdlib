classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017b', 'impure'}) ...
    TestFileImpure < matlab.unittest.TestCase

properties (TestParameter)
ph = {{0, '"stdin"'}, {1, '"stdout"'}, {2, '"stderr"'}, {fopen(tempname()), ''}}
end

methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end


methods (Test)

function test_file_size(tc)
n = 'test_file_size.bin';
fid = fopen(n, 'wb');
fwrite(fid, 0, 'uint8');
fclose(fid);

s = stdlib.file_size(n);
tc.verifyEqual(s, 1)
end


function test_null_file(tc)
n = stdlib.null_file;

if ispc()
  tc.verifyEqual(n, 'NUL')
elseif stdlib.matlabOlderThan('R2019b')
  tc.verifyEqual(n, '/dev/null')
else
  tc.verifyThat(n, matlab.unittest.constraints.IsFile)
end
end


function test_makedir(tc)
d = 'test_makedir.dir';
stdlib.makedir(d)

if stdlib.matlabOlderThan('R2018a')
  tc.assertTrue(isfolder(d))
else
  tc.verifyThat(d, matlab.unittest.constraints.IsFolder)
end
end


function test_handle2filename(tc, ph)
tc.verifyEqual(stdlib.handle2filename(ph{1}), ph{2})
end

end

end
