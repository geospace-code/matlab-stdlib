classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017b', 'symlink'}) ...
    TestSymlink < matlab.unittest.TestCase

properties
target
link
end

properties (TestParameter)
Pre = {'', "", tempname()}
B_create_symlink = {'native', 'dotnet', 'python', 'sys'}
B_is_symlink = {'native', 'java', 'python', 'dotnet', 'sys'}
end


methods(TestMethodSetup)
% needs to be per-method because multiple functions are used to make the same files

function setup_symlink(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());

tc.link = fullfile(pwd(), 'my.lnk');

tc.target = fullfile(pwd(), 'my_target.txt');
tc.assertTrue(stdlib.touch(tc.target), "failed to create test target " + tc.target)

tc.assertTrue(stdlib.create_symlink(tc.target, tc.link), ...
    "failed to create test link " + tc.link)
end
end



methods (Test)

function test_is_symlink(tc, B_is_symlink)
[i, b] = stdlib.is_symlink(tc.link, B_is_symlink);
tc.assertEqual(char(b), B_is_symlink)

if ismember(B_is_symlink, stdlib.Backend().select('is_symlink'))
  tc.assertTrue(i, "failed to detect own link " + tc.link)

  tc.verifyFalse(stdlib.is_symlink('', B_is_symlink))
  tc.verifyFalse(stdlib.is_symlink(tc.target, B_is_symlink))
else
  tc.verifyEmpty(i)
end
end


function test_read_symlink_empty(tc, Pre, B_is_symlink)
[r, b] = stdlib.read_symlink(Pre, B_is_symlink);
tc.assertEqual(char(b), B_is_symlink)

tc.verifyEqual(r, string.empty)
end


function test_read_symlink(tc, B_is_symlink)
r = stdlib.read_symlink(tc.link, B_is_symlink);
tc.verifyClass(r, 'string')

if ismember(B_is_symlink, stdlib.Backend().select('read_symlink'))
  tc.verifyEqual(r, string(tc.target))
else
  tc.verifyEmpty(r)
end
end


function test_create_symlink(tc, B_create_symlink)
tc.applyFixture(matlab.unittest.fixtures.SuppressedWarningsFixture(...
  ["MATLAB:io:filesystem:symlink:TargetNotFound","MATLAB:io:filesystem:symlink:FileExists"]));

ano = fullfile(pwd(), 'another.lnk');
tc.assertFalse(isfile(ano))
tc.assertFalse(stdlib.is_symlink(ano))

r = stdlib.create_symlink(tc.target, ano, B_create_symlink);

if ismember(B_create_symlink, stdlib.Backend().select('create_symlink'))
  tc.verifyTrue(r)
elseif ispc() && B_create_symlink == "native"
  tc.verifyTrue(isempty(r) || r)
else
  tc.verifyEmpty(r)
end
end


function test_create_symlink_empty(tc, B_create_symlink)
[i, b] = stdlib.create_symlink('', tempname(), B_create_symlink);
tc.assertEqual(char(b), B_create_symlink)

if ismember(B_create_symlink, stdlib.Backend().select('create_symlink'))
  if ispc() && B_create_symlink == "native"
    tc.verifyTrue( isempty(i) || ~i )
  else
    tc.verifyFalse(i)
  end
else
  tc.verifyTrue( isempty(i) || ~i )
end
end


function test_create_symlink_exist(tc, B_create_symlink)
i = stdlib.create_symlink(tc.target, tc.link, B_create_symlink);

if ismember(B_create_symlink, stdlib.Backend().select('create_symlink'))
  if ispc() && B_create_symlink == "native"
    tc.verifyTrue( isempty(i) || ~i )
  else
    tc.verifyFalse(i, "should fail for existing symlink")
  end
else
  tc.verifyTrue( isempty(i) || ~i )
end

end

end
end
