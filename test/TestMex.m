classdef TestMex < matlab.unittest.TestCase

methods (Test, TestTags = "mex")

function test_is_char_device(tc)
% /dev/stdin may not be available on CI systems
if ispc
  n = "NUL";
else
  n = "/dev/null";
end

tc.verifyTrue(stdlib.is_char_device(n))
end


function test_is_admin(tc)
tc.verifyClass(stdlib.is_admin(), "logical")
end


function test_remove_file(tc)
import matlab.unittest.constraints.IsFile
tc.assertThat(fileparts(mfilename("fullpath")) + "/../+stdlib/remove." + mexext, IsFile)

d = tc.createTemporaryFolder();

f = tempname(d);

tc.verifyFalse(stdlib.remove(f), "should not succeed at removing non-existant path")

tc.assumeTrue(stdlib.touch(f))
tc.verifyTrue(stdlib.remove(f), "failed to remove file")
end


function test_remove_empty_dir(tc)
import matlab.unittest.constraints.IsFile
tc.assertThat(fileparts(mfilename("fullpath")) + "/../+stdlib/remove." + mexext, IsFile)

d = tc.createTemporaryFolder();

tc.verifyTrue(stdlib.remove(d), "failed to remove empty directory")
end


function test_remove_recursive(tc)
import matlab.unittest.constraints.IsFile
tc.assertThat(fileparts(mfilename("fullpath")) + "/../+stdlib/remove." + mexext, IsFile)

d = tc.createTemporaryFolder();

tc.assumeTrue(stdlib.touch(fullfile(d, "junk.txt")))
tc.verifyFalse(stdlib.remove(d), "should not remove directory recursively")
end

end

end
