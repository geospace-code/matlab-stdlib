classdef (TestTags = {'R2019b', 'symlink', 'impure'}) ...
    TestSymlink < matlab.unittest.TestCase

properties
target
link
end

properties (TestParameter)
p = {{"not-exist", false}, ...
    {mfilename("fullpath") + ".m", false}, ...
    {"", false}};
Pre = {'', "", tempname()}
backend_dnps = init_backend({'native', 'sys', 'dotnet', 'python'}, 'native', ~isMATLABReleaseOlderThan('R2025a'))
backend_djnps = init_backend({'native', 'sys', 'dotnet', 'java', 'python'}, 'native', ~isMATLABReleaseOlderThan('R2025a'))
end

methods(TestClassSetup)
function setupClass(tc)
pkg_path(tc)
end
end

methods(TestMethodSetup)
% needs to be per-method because multiple functions are used to make the same files

function setup_symlink(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())

tc.link = fullfile(pwd(), 'my.lnk');

tc.target = strcat(mfilename("fullpath"), '.m');

tc.assumeTrue(stdlib.create_symlink(tc.target, tc.link), ...
    "failed to create test link " + tc.link)
end
end



methods (Test)

function test_is_symlink(tc, p, backend_djnps)
tc.verifyTrue(stdlib.is_symlink(tc.link, backend_djnps), "failed to detect own link")
tc.verifyEqual(stdlib.is_symlink(p{1}, backend_djnps), p{2}, p{1})
end

function test_is_symlink_array(tc, backend_djnps)
r = stdlib.is_symlink([tc.link, mfilename() + ".m"], backend_djnps);
tc.verifyEqual(r, [true, false], "failed to detect own link")
end


function test_read_symlink_empty(tc, Pre, backend_djnps)
tc.verifyEqual(stdlib.read_symlink(Pre, backend_djnps), "")
end


function test_read_symlink(tc, backend_djnps)
r = stdlib.read_symlink(tc.link, backend_djnps);
tc.verifyClass(r, 'string')
if backend_djnps == "dotnet" && stdlib.dotnet_api() < 6
  tc.verifyEqual(r, "")
else
  tc.verifyEqual(r, string(tc.target))
end
end


function test_read_symlink_array(tc, backend_djnps)
r = stdlib.read_symlink([tc.link, mfilename() + ".m"], backend_djnps);
exp = [tc.target, ""];
if backend_djnps == "dotnet" && stdlib.dotnet_api() < 6
  exp(1) = "";
end
tc.verifyClass(r, 'string')
tc.verifyEqual(r, exp, "failed to detect own link")
end


function test_create_symlink(tc, backend_dnps)
tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture(["MATLAB:io:filesystem:symlink:TargetNotFound","MATLAB:io:filesystem:symlink:FileExists"]))

ano = fullfile(pwd(), 'another.lnk');

h = @stdlib.create_symlink;

tc.verifyFalse(h('', tempname(), backend_dnps))
tc.verifyFalse(h(tc.target, tc.link, backend_dnps), "should fail for existing symlink")

exp = true;
if (backend_dnps == "dotnet" && stdlib.dotnet_api() < 6) || ...
   (backend_dnps == "native" && (isMATLABReleaseOlderThan('R2024b') || (ispc() && isMATLABReleaseOlderThan('R2025a'))))
  exp = false;
end

tc.assertThat(ano, ~matlab.unittest.constraints.IsFile)
tc.assertFalse(stdlib.is_symlink(ano))

tc.verifyEqual(h(tc.target, ano, backend_dnps), exp)
end

end
end
