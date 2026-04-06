classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}) ...
    TestExists < matlab.unittest.TestCase

properties (TestParameter)
Ps = init_val()

backend_chardev
not_backend_chardev
end


methods (TestParameterDefinition, Static)
function [backend_chardev, not_backend_chardev] = setup_backend()
  rpath = fileparts(fileparts(mfilename('fullpath')));
  addpath(rpath)

  not_backend_chardev = {};
  backend_chardev = {};
  for b = ["python", "sys"]
    if isempty(stdlib.is_char_device(rpath, b))
      not_backend_chardev{end+1} = char(b); %#ok<AGROW>
    else
      backend_chardev{end+1} = char(b); %#ok<AGROW>
    end
  end

  rmpath(rpath)
end
end

methods(TestClassSetup)
function test_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end


methods (Test, TestTags={'R2016a'})

function test_exists(tc, Ps)
r = stdlib.exists(Ps{1});
tc.verifyEqual(r, Ps{2}, Ps{1})

if ~stdlib.matlabOlderThan('R2016b')
  r = stdlib.exists(string(Ps{1}));
  tc.verifyEqual(r, Ps{2})
end
end


function test_is_readable(tc, Ps)
r = stdlib.is_readable(Ps{1});
tc.verifyEqual(r, Ps{2})

if ~stdlib.matlabOlderThan('R2016b')
  r = stdlib.is_readable(string(Ps{1}));
  tc.verifyEqual(r, Ps{2});
end
end

function test_is_writable(tc, Ps)
r = stdlib.is_writable(Ps{1});
tc.verifyEqual(r, Ps{2})

if ~stdlib.matlabOlderThan('R2016b')
  r = stdlib.is_writable(string(Ps{1}));
  tc.verifyEqual(r, Ps{2});
end
end
end


methods (Test, TestTags={'R2019b'})
function test_is_char_device(tc, backend_chardev)
% /dev/stdin may not be available on CI systems
n = stdlib.null_file();

[r, b] = stdlib.is_char_device(n, backend_chardev);
tc.assertEqual(b, backend_chardev)
tc.assertClass(r, 'logical')

tc.verifyTrue(r, n)

if ~stdlib.matlabOlderThan('R2016b')
  tc.verifyTrue(stdlib.is_char_device(string(n), backend_chardev))
end
end

function test_missing_backend(tc, not_backend_chardev)
n = stdlib.null_file();
[r, b] = stdlib.is_char_device(n, not_backend_chardev);
tc.verifyEqual(b, not_backend_chardev)
tc.verifyEmpty(r)
end

end

end


function Ps = init_val()


Ps = {
  {pwd(), true}, ...
  {tempname(), false}, ...
  {'', false}
};

o = mfilename('fullpath');
if ~isempty(o)
  o = [o, '.m'];
  Ps = [Ps, {
    {o, true}, ...
    {[fileparts(o), '/../Readme.md'], true}
    }
  ];
end

if ispc()
  % On Windows, the root of the system drive is considered to exist
  systemDrive = getenv('SystemDrive');
  if ~isempty(systemDrive)
    Ps{end+1} = {systemDrive, true};
  end
end
end
