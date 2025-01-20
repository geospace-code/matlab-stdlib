classdef TestSymlink < matlab.unittest.TestCase

properties
target
link
tempDir
end

properties (TestParameter)
p = init_symlink()
end


methods(TestClassSetup)
function setup_symlink(tc)
tc.tempDir = stdlib.posix(tc.createTemporaryFolder());

tc.link = tc.tempDir + "/my.lnk";

tc.target = stdlib.posix(mfilename("fullpath") + ".m");

tc.assumeTrue(stdlib.create_symlink(tc.target, tc.link), ...
    "failed to create test link " + tc.link)
end
end


methods (Test)

function test_is_symlink(tc, p)
tc.verifyTrue(stdlib.is_symlink(tc.link), "failed to detect own link")
tc.verifyEqual(stdlib.is_symlink(p{1}), p{2}, p{1})
end


function test_read_symlink(tc)

tc.verifyEqual(stdlib.read_symlink(""), "")
tc.verifyEqual(stdlib.read_symlink("not-exist"), "")
tc.verifyEqual(stdlib.read_symlink(tc.target), "")

t = stdlib.read_symlink(tc.link);
tc.verifyNotEmpty(t)
tc.verifyClass(t, 'string')
tc.verifyEqual(tc.target, t)

end


function test_create_symlink(tc)
tc.verifyFalse(stdlib.create_symlink("", tempname))
tc.verifyFalse(stdlib.create_symlink(tc.target, tc.link), "should fail for existing symlink")

ano = tc.tempDir + "/another.lnk";
tc.verifyTrue(stdlib.create_symlink(tc.target, ano))
tc.verifyTrue(stdlib.is_symlink(ano))
end

end
end


function p = init_symlink()
p = {{"not-exist", false}, ...
  {mfilename("fullpath") + ".m", false}, ...
  {"", false}};
end
