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
create_symlink_fun = {@stdlib.create_symlink, @stdlib.sys.create_symlink, @stdlib.dotnet.create_symlink, @stdlib.python.create_symlink}
Pre = {'', "", tempname()}
rs_fun = {'native', 'sys', 'dotnet', 'java', 'python'}
end

methods(TestClassSetup)
function pkg_path(tc)
slp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(slp)
end
end

methods(TestMethodSetup)
% needs to be per-method because multiple functions are used to make the same files

function setup_symlink(tc)

tc.assumeFalse(isMATLABReleaseOlderThan('R2022a'))

tc.td = tc.createTemporaryFolder();

tc.link = fullfile(tc.td, 'my.lnk');

tc.target = strcat(mfilename("fullpath"), '.m');

tc.assumeTrue(stdlib.create_symlink(tc.target, tc.link), ...
    "failed to create test link " + tc.link)
end
end



methods (Test, TestTags=["impure", "symlink"])

function test_is_symlink(tc, p, rs_fun)
tc.assertNotEmpty(which("stdlib." + rs_fun + ".is_symlink"))
try
  tc.verifyTrue(stdlib.is_symlink(tc.link, rs_fun), "failed to detect own link")
  tc.verifyEqual(stdlib.is_symlink(p{1}, rs_fun), p{2}, p{1})
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
end
end


function test_read_symlink_empty(tc, Pre, rs_fun)
try
  tc.verifyEmpty(stdlib.read_symlink(Pre, rs_fun))
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
end
end


function test_read_symlink(tc, rs_fun)
tc.assertNotEmpty(which("stdlib." + rs_fun + ".read_symlink"))
try
  tc.verifyEqual(stdlib.read_symlink(tc.link, rs_fun), string(tc.target))
catch e
  tc.verifyEqual(e.identifier, 'stdlib:choose_method:NameError', e.message)
end
end


function test_create_symlink(tc, create_symlink_fun)
is_capable(tc, create_symlink_fun)

tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture(["MATLAB:io:filesystem:symlink:TargetNotFound","MATLAB:io:filesystem:symlink:FileExists"]))

tc.verifyFalse(create_symlink_fun('', tempname()))
tc.verifyFalse(create_symlink_fun(tc.target, tc.link), "should fail for existing symlink")

ano = tc.td + "/another.lnk";
tc.verifyTrue(create_symlink_fun(tc.target, ano))
tc.verifyTrue(stdlib.is_symlink(ano))
end

end
end
