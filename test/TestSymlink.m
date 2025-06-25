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

tc.tempDir = tc.createTemporaryFolder();

tc.link = fullfile(tc.tempDir, 'my.lnk');

tc.target = strcat(mfilename("fullpath"), '.m');

tc.assumeTrue(stdlib.create_symlink(tc.target, tc.link), ...
    "failed to create test link " + tc.link)
end
end


methods (Test, TestTags="symlink")

function test_is_symlink(tc, p)
fprintf("is_symlink  mex: %d\n", stdlib.is_mex_fun("stdlib.is_symlink"))
tc.verifyTrue(stdlib.is_symlink(tc.link), "failed to detect own link")
tc.verifyEqual(stdlib.is_symlink(p{1}), p{2}, p{1})
end


function test_read_symlink(tc)
fprintf("read_symlink  mex: %d\n", stdlib.is_mex_fun("stdlib.read_symlink"))
tc.verifyEmpty(stdlib.read_symlink(""))
tc.verifyEmpty(stdlib.read_symlink(''))
tc.verifyEmpty(stdlib.read_symlink(tempname))
tc.verifyEmpty(stdlib.read_symlink(tc.target))


t = stdlib.read_symlink(tc.link);

targ = string(tc.target);

tc.verifyEqual(targ, t)

end


function test_create_symlink(tc)
fprintf("create_symlink  mex: %d\n", stdlib.is_mex_fun("stdlib.create_symlink"))

tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture(["MATLAB:io:filesystem:symlink:TargetNotFound","MATLAB:io:filesystem:symlink:FileExists"]))

tc.verifyFalse(stdlib.create_symlink('', tempname()))
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
