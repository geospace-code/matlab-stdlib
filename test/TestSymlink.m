classdef TestSymlink < matlab.unittest.TestCase

properties
target
link
td
end

properties (TestParameter)
p = {{"not-exist", false}, ...
    {mfilename("fullpath") + ".m", false}, ...
    {"", false}};
is_symlink_fun   = {@stdlib.is_symlink,   @stdlib.sys.is_symlink,   @stdlib.dotnet.is_symlink,   @stdlib.java.is_symlink,   @stdlib.python.is_symlink}
read_symlink_fun = {@stdlib.read_symlink, @stdlib.sys.read_symlink, @stdlib.dotnet.read_symlink, @stdlib.java.read_symlink, @stdlib.python.read_symlink}
end


methods(TestClassSetup)

function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
end

function setup_symlink(tc)

tc.link = fullfile(tc.td, 'my.lnk');

tc.target = strcat(mfilename("fullpath"), '.m');

tc.assumeTrue(stdlib.create_symlink(tc.target, tc.link), ...
    "failed to create test link " + tc.link)
end
end


methods(TestClassTeardown)
function remove_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  [s, m, i] = rmdir(tc.td, 's');
  if ~s, warning(i, "Failed to remove temporary directory %s: %s", tc.td, m); end
end
end
end


methods (Test, TestTags=["impure", "symlink"])

function test_is_symlink(tc, p, is_symlink_fun)
is_capable(tc, is_symlink_fun)

tc.verifyTrue(is_symlink_fun(tc.link), "failed to detect own link")
tc.verifyEqual(is_symlink_fun(p{1}), p{2}, p{1})
end


function test_read_symlink(tc, read_symlink_fun)
is_capable(tc, read_symlink_fun)

tc.verifyEmpty(read_symlink_fun(""))
tc.verifyEmpty(read_symlink_fun(''))
tc.verifyEmpty(read_symlink_fun(tempname))
tc.verifyEmpty(read_symlink_fun(tc.target))

link_read = read_symlink_fun(tc.link);

targ = string(tc.target);

tc.verifyEqual(link_read, targ)

end


function test_create_symlink(tc)
fprintf("create_symlink  mex: %d\n", stdlib.is_mex_fun("stdlib.create_symlink"))

tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture(["MATLAB:io:filesystem:symlink:TargetNotFound","MATLAB:io:filesystem:symlink:FileExists"]))

tc.verifyFalse(stdlib.create_symlink('', tempname()))
tc.verifyFalse(stdlib.create_symlink(tc.target, tc.link), "should fail for existing symlink")

ano = tc.td + "/another.lnk";
tc.verifyTrue(stdlib.create_symlink(tc.target, ano))
tc.verifyTrue(stdlib.is_symlink(ano))
end

end
end
