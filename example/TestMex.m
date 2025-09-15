classdef TestMex < matlab.unittest.TestCase

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end

methods (Test, TestTags = "mex")

function test_remove_file(tc)
tc.assertTrue(stdlib.is_mex_fun("stdlib.remove"))

d = tc.createTemporaryFolder();

f = tempname(d);

tc.verifyFalse(stdlib.remove(f), "should not succeed at removing non-existant path")

tc.assumeTrue(stdlib.touch(f), "failed to touch file " + f)
tc.verifyTrue(stdlib.remove(f), "failed to remove file " + f)
end


function test_remove_empty_dir(tc)
tc.assertTrue(stdlib.is_mex_fun("stdlib.remove"))

d = tc.createTemporaryFolder();

tc.verifyTrue(stdlib.remove(d), "failed to remove empty directory")
end


function test_remove_recursive(tc)
tc.assertTrue(stdlib.is_mex_fun("stdlib.remove"))

d = tc.createTemporaryFolder();

tc.assumeTrue(stdlib.touch(fullfile(d, 'junk.txt')))
tc.verifyFalse(stdlib.remove(d), "should not remove directory recursively")
end

end

end
