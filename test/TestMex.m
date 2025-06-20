classdef TestMex < matlab.unittest.TestCase

methods (Test)

function test_is_char_device(tc)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))
% matlab exist() doesn't work for MEX detection with ".." leading path
tc.assumeEqual(exist("+stdlib/is_char_device", "file"), 3)

% /dev/stdin may not be available on CI systems
if ispc
  n = "NUL";
else
  n = "/dev/null";
end

tc.verifyTrue(stdlib.is_char_device(n))
end


function test_is_admin(tc)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))
tc.assumeEqual(exist("+stdlib/is_admin", "file"), 3)

tc.verifyClass(stdlib.is_admin(), "logical")
end


function test_unlink_file(tc)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))
tc.assumeEqual(exist("+stdlib/unlink", "file"), 3)

d = tc.createTemporaryFolder();

f = tempname(d);

tc.verifyFalse(stdlib.unlink(f), "should not succeed at unlinking non-existant path")

tc.assumeTrue(stdlib.touch(f))
tc.verifyTrue(stdlib.unlink(f), "failed to unlink file")
end


function test_unlink_empty_dir(tc)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))
tc.assumeEqual(exist("+stdlib/unlink", "file"), 3)

d = tc.createTemporaryFolder();

tc.verifyTrue(stdlib.unlink(d), "failed to unlink empty directory")
end


function test_unlink_recursive(tc)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))
tc.assumeEqual(exist("+stdlib/unlink", "file"), 3)

d = tc.createTemporaryFolder();

tc.assumeTrue(stdlib.touch(fullfile(d, "junk.txt")))
tc.verifyFalse(stdlib.unlink(d), "should not unlink directory recursively")
end

end

end
