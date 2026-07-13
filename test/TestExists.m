classdef TestExists < WorkingClassDir

properties (TestParameter)
Ps = init_val()
B_is_char_device = {'python', 'shell'}
end

methods (Test)

function test_is_readable_not_exist(tc)
e = 'MATLAB:validators:mustBeFileOrFolder';
tc.verifyError(@() stdlib.is_readable(''), e)
tc.verifyError(@() stdlib.is_readable('not-here'), e)
end

function test_is_writable_not_exist(tc)
e = 'MATLAB:validators:mustBeFileOrFolder';
tc.verifyError(@() stdlib.is_writable(''), e)
tc.verifyError(@() stdlib.is_writable('not-here'), e)
end

function test_exists(tc, Ps)
r = stdlib.exists(Ps{1});
tc.verifyEqual(r, Ps{2}, Ps{1})

r = stdlib.exists(string(Ps{1}));
tc.verifyEqual(r, Ps{2})
end

function test_not_exists(tc)
tc.verifyFalse(stdlib.exists(''))
tc.verifyFalse(stdlib.exists(tempname()))
end

function test_is_readable(tc, Ps)
r = stdlib.is_readable(Ps{1});
tc.verifyEqual(r, Ps{2})

s = string(Ps{1});
r = stdlib.is_readable(s);
tc.verifyEqual(r, Ps{2});

r = stdlib.is_readable([s, s]);
tc.verifyEqual(r, [Ps{2}, Ps{2}]);

r = stdlib.is_readable([s; s]);
tc.verifyEqual(r, [Ps{2}; Ps{2}]);
end

function test_is_writable(tc, Ps)
r = stdlib.is_writable(Ps{1});
tc.verifyEqual(r, Ps{2})

s = string(Ps{1});
r = stdlib.is_writable(s);
tc.verifyEqual(r, Ps{2});

r = stdlib.is_writable([s, s]);
tc.verifyEqual(r, [Ps{2}, Ps{2}]);

r = stdlib.is_writable([s; s]);
tc.verifyEqual(r, [Ps{2}; Ps{2}]);
end

function test_is_char_device(tc, B_is_char_device)
% /dev/stdin may not be available on CI systems
n = stdlib.null_file();

[r, b] = stdlib.is_char_device(n, B_is_char_device);

if ismember(B_is_char_device, stdlib.Backend().select('is_char_device'))
  tc.assertMatches(b, B_is_char_device)
  tc.assertClass(r, 'logical')
  tc.verifyTrue(r, n)

  tc.verifyTrue(stdlib.is_char_device(string(n), B_is_char_device))
else
  tc.verifyEqual(r, missing)
end
end
end

end


function Ps = init_val()


Ps = {{pwd(), true}};

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
