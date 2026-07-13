classdef (TestTags = {'impure'}) TestFileImpure < WorkingClassDir

properties (TestParameter)
ph = {{0, '"stdin"'}, {1, '"stdout"'}, {2, '"stderr"'}, {fopen(tempname()), missing}}
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
else
  tc.verifyThat(n, matlab.unittest.constraints.IsFile)
end
end


function test_makedir(tc)
d = 'test_makedir.dir';
tc.assertTrue(stdlib.makedir(d))

tc.verifyThat(d, matlab.unittest.constraints.IsFolder)
end


function test_handle2filename(tc, ph)
tc.verifyEqual(stdlib.handle2filename(ph{1}), ph{2})
end

end

end
