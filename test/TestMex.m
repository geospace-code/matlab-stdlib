classdef TestMex < matlab.unittest.TestCase

methods (Test)

function test_is_char_device(tc)

tc.assumeTrue(isfile(fileparts(mfilename("fullpath")) + "/../+stdlib/is_char_device." + mexext))

% /dev/stdin may not be available on CI systems
if ispc
  n = "NUL";
else
  n = "/dev/null";
end

tc.verifyTrue(stdlib.is_char_device(n))
end


function test_is_admin(tc)
tc.assumeTrue(isfile(fileparts(mfilename("fullpath")) + "/../+stdlib/is_admin." + mexext))

tc.verifyClass(stdlib.is_admin(), "logical")
end


function test_remove_file(tc)
tc.assumeTrue(isfile(fileparts(mfilename("fullpath")) + "/../+stdlib/remove." + mexext))

d = tc.createTemporaryFolder();

f = tempname(d);

tc.verifyFalse(stdlib.remove(f), "should not succeed at removing non-existant path")

tc.assumeTrue(stdlib.touch(f))
tc.verifyTrue(stdlib.remove(f), "failed to remove file")
end


function test_remove_empty_dir(tc)
tc.assumeTrue(isfile(fileparts(mfilename("fullpath")) + "/../+stdlib/remove." + mexext))

d = tc.createTemporaryFolder();

tc.verifyTrue(stdlib.remove(d), "failed to remove empty directory")
end


function test_remove_recursive(tc)
tc.assumeTrue(isfile(fileparts(mfilename("fullpath")) + "/../+stdlib/remove." + mexext))

d = tc.createTemporaryFolder();

tc.assumeTrue(stdlib.touch(fullfile(d, "junk.txt")))
tc.verifyFalse(stdlib.remove(d), "should not remove directory recursively")
end

end

end
