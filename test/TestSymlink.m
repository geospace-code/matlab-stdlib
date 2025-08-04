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
cs_backend = {'native', 'sys', 'dotnet', 'python'}
Pre = {'', "", tempname()}
ir_backend = {'native', 'sys', 'dotnet', 'java', 'python'}
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

function test_is_symlink(tc, p, ir_backend)
tc.assertNotEmpty(which("stdlib." + ir_backend + ".is_symlink"))
try
  tc.verifyTrue(stdlib.is_symlink(tc.link, ir_backend), "failed to detect own link")
  tc.verifyEqual(stdlib.is_symlink(p{1}, ir_backend), p{2}, p{1})
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end

function test_is_symlink_array(tc, ir_backend)
try
  r = stdlib.is_symlink([tc.link, mfilename() + ".m"], ir_backend);
  tc.verifyEqual(r, [true, false], "failed to detect own link")
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_read_symlink_empty(tc, Pre, ir_backend)
try
  tc.verifyEmpty(stdlib.read_symlink(Pre, ir_backend))
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_read_symlink(tc, ir_backend)
tc.assertNotEmpty(which("stdlib." + ir_backend + ".read_symlink"))
try
  tc.verifyEqual(stdlib.read_symlink(tc.link, ir_backend), string(tc.target))
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
end
end


function test_create_symlink(tc, cs_backend)
tc.assumeNotEmpty(which("stdlib." + cs_backend + ".create_symlink"))
tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture(["MATLAB:io:filesystem:symlink:TargetNotFound","MATLAB:io:filesystem:symlink:FileExists"]))

ano = tc.td + "/another.lnk";

h = @stdlib.create_symlink;

try
  tc.verifyFalse(h('', tempname(), cs_backend))
  tc.verifyFalse(h(tc.target, tc.link, cs_backend), "should fail for existing symlink")
  tc.verifyTrue(h(tc.target, ano, cs_backend))
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end
tc.verifyTrue(stdlib.is_symlink(ano))
end

end
end
