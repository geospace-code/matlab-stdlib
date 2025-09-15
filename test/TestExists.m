classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    TestExists < matlab.unittest.TestCase

properties (TestParameter)
Ps = init_val()
B_is_char_device = {'python', 'sys'}
end


methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods (Test, TestTags={'R2018a'})

function test_exists(tc, Ps)
r = stdlib.exists(Ps{1});
tc.verifyEqual(r, Ps{2}, Ps{1})

r = stdlib.exists(string(Ps{1}));
tc.verifyEqual(r, Ps{2})
end


function test_is_readable(tc, Ps)
r = stdlib.is_readable(Ps{1});
tc.verifyEqual(r, Ps{2})

r = stdlib.is_readable(string(Ps{1}));
tc.verifyEqual(r, Ps{2});
end

function test_is_writable(tc, Ps)
r = stdlib.is_writable(Ps{1});
tc.verifyEqual(r, Ps{2})

r = stdlib.is_writable(string(Ps{1}));
tc.verifyEqual(r, Ps{2});
end
end


methods (Test, TestTags={'R2019b'})
function test_is_char_device(tc, B_is_char_device)
% /dev/stdin may not be available on CI systems
n = stdlib.null_file();

[r, b] = stdlib.is_char_device(n, B_is_char_device);
tc.assertEqual(char(b), B_is_char_device)
tc.assertClass(r, 'logical')

if ismember(B_is_char_device, stdlib.Backend().select('is_char_device'))
  tc.verifyTrue(r, n)

  tc.verifyTrue(stdlib.is_char_device(string(n), B_is_char_device))
else
  tc.verifyEmpty(r)
end
end
end

end


function Ps = init_val()
Ps = {
  {pwd(), true}, ...
  {[mfilename("fullpath"), '.m'], true}, ...
  {[fileparts(mfilename("fullpath")), '/../Readme.md'], true}, ...
  {tempname(), false}, ...
  {'', false}
};
if ispc()
  % On Windows, the root of the system drive is considered to exist
  systemDrive = getenv("SystemDrive");
  if ~isempty(systemDrive)
    Ps{end+1} = {systemDrive, true};
  end
end
end
