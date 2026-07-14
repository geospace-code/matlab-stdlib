classdef (TestTags = {'symlink'}) TestSymlink < StdlibPath

properties
target
link
end

properties (TestParameter)
Pre = {'', tempname()}
B_create_symlink = {'native', 'dotnet', 'python', 'shell'}
B_is_symlink = {'native', 'java', 'python', 'dotnet', 'shell'}
end


methods(TestMethodSetup)
% needs to be per-method because multiple functions are used to make the same files

function setup_symlink(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());

tc.link = fullfile(pwd(), 'my.lnk');

tc.target = fullfile(pwd(), 'my_target.txt');
tc.assertTrue(stdlib.touch(tc.target), 'failed to create test target')

ok = stdlib.create_symlink(tc.target, tc.link);
tc.assertTrue(ok, 'failed to create test link')
end
end



methods (Test)

function test_is_symlink(tc, B_is_symlink)

tc.verifyError(@() stdlib.is_symlink('', B_is_symlink), 'MATLAB:validators:mustBeFileOrFolder')

[i, b] = stdlib.is_symlink(tc.link, B_is_symlink);

if ismember(B_is_symlink, stdlib.Backend().select('is_symlink'))
  tc.assertMatches(b, B_is_symlink)
  tc.assertTrue(i, 'failed to detect own link')

  tc.verifyFalse(stdlib.is_symlink(tc.target, B_is_symlink))
else
  tc.verifyEqual(i, missing)
end
end


function test_read_symlink(tc, B_is_symlink)

if ~isMATLABReleaseOlderThan('R2024b')
tc.verifyError(@() stdlib.read_symlink('', B_is_symlink), 'MATLAB:validators:mustBeSymbolicLink')
end

[r, b] = stdlib.read_symlink(tc.link, B_is_symlink);

if ismember(B_is_symlink, stdlib.Backend().select('read_symlink'))
  tc.assertMatches(b, B_is_symlink)
  tc.verifyClass(r, 'string')
  tc.verifyEqual(r, string(tc.target))
else
  tc.verifyEqual(r, missing)
end
end


function test_create_symlink(tc, B_create_symlink)
tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture(...
  {'MATLAB:io:filesystem:symlink:TargetNotFound','MATLAB:io:filesystem:symlink:FileExists'}));

ano = fullfile(pwd(), 'another.lnk');
tc.assertFalse(stdlib.exists(ano) && stdlib.is_symlink(ano))

[r, b] = stdlib.create_symlink(tc.target, ano, B_create_symlink);

if ismember(B_create_symlink, stdlib.Backend().select('create_symlink'))
  tc.assertMatches(b, B_create_symlink)
  tc.verifyTrue(r)
elseif ispc() && strcmp(B_create_symlink, 'native')
  tc.verifyTrue(ismissing(r) || r)
else
  tc.verifyEqual(r, missing)
end
end


function test_create_symlink_empty(tc, B_create_symlink)
tc.verifyError(@() stdlib.create_symlink('', '', B_create_symlink), 'MATLAB:validators:mustBeFileOrFolder')
end


function test_create_symlink_exist(tc, B_create_symlink)
i = stdlib.create_symlink(tc.target, tc.link, B_create_symlink);

if ismember(B_create_symlink, stdlib.Backend().select('create_symlink'))
  if ispc() && strcmp(B_create_symlink, 'native')
    tc.verifyTrue( ismissing(i) || ~i )
  else
    tc.verifyFalse(i, 'should fail for existing symlink')
  end
else
  tc.verifyTrue( ismissing(i) || ~i )
end

end

end
end
