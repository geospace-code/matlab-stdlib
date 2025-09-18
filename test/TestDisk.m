classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a'}) ...
  TestDisk < matlab.unittest.TestCase

properties
CI = is_ci()
end

properties (TestParameter)
Ps = {'.', '', '/', pwd(), getenv('SystemDrive'), 'not-exist'}
B_ps = {'python', 'sys'}
B_jps = {'java', 'python', 'sys'}
B_jdps = {'java', 'dotnet', 'python', 'sys'}
end

methods(TestClassSetup)
function test_dirs(tc)
  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end

methods (Test)

function test_disk_available(tc, Ps, B_jdps)
[r, b] = stdlib.disk_available(Ps, B_jdps);
tc.assertEqual(char(b), B_jdps)

tc.verifyClass(r, 'uint64')

if ismember(B_jdps, stdlib.Backend().select('disk_available'))
  if stdlib.exists(Ps)
    tc.verifyGreaterThanOrEqual(r, 0)
  else
    tc.verifyEmpty(r)
  end
else
  tc.verifyEmpty(r)
end

end


function test_disk_capacity(tc, Ps, B_jdps)
[r, b] = stdlib.disk_capacity(Ps, B_jdps);
tc.assertEqual(char(b), B_jdps)

tc.verifyClass(r, 'uint64')

if ismember(B_jdps, stdlib.Backend().select('disk_capacity'))
  if stdlib.exists(Ps)
    tc.verifyGreaterThanOrEqual(r, 0)
  else
    tc.verifyEmpty(r)
  end
else
  tc.verifyEmpty(r)
end

end


function test_is_removable(tc, B_ps)
[y, b] = stdlib.is_removable(pwd(), B_ps);
tc.assertEqual(char(b), B_ps)
tc.verifyClass(y, 'logical')
end

function test_is_mount(tc, B_ps)
[y,b] = stdlib.is_mount(pwd(), B_ps);
tc.assertEqual(char(b), B_ps)
tc.verifyClass(y, 'logical')

if ismember(B_ps, stdlib.Backend().select('is_mount'))
  tc.verifyTrue(stdlib.is_mount('/', B_ps))
  tc.verifyFalse(stdlib.is_mount(tempname(), B_ps))

  if ispc()
    sd = getenv('SystemDrive');
    tc.assertEqual(sd, stdlib.root_name(sd))
    tc.verifyFalse(stdlib.is_mount(sd, B_ps), sd)
    tc.verifyTrue(stdlib.is_mount([sd '/'], B_ps), sd)
    tc.verifyTrue(stdlib.is_mount([sd filesep], B_ps), sd)
  end
else
  tc.verifyEmpty(y)
end
end


function test_hard_link_count(tc, B_jps)
fn = 'test_hard_link_count.txt';
tc.assertTrue(stdlib.touch(fn))

[i, b] = stdlib.hard_link_count(fn, B_jps);
tc.assertEqual(char(b), B_jps)

if ismember(B_jps, stdlib.Backend().select('hard_link_count'))
  tc.verifyGreaterThanOrEqual(i, 1)
else
  tc.assertEmpty(i)
end

i = stdlib.hard_link_count('');
tc.verifyEmpty(i)
end


function test_filesystem_type(tc, Ps, B_jdps)
[t, b] = stdlib.filesystem_type(Ps, B_jdps);
tc.assertEqual(char(b), B_jdps)
tc.verifyClass(t, 'char')

if ismember(B_jdps, stdlib.Backend().select('filesystem_type'))
  if ~stdlib.exists(Ps)
    tc.verifyEmpty(t)
  else
    tc.assumeFalse(isempty(t) && tc.CI, 'Some CI block viewing their filesystem type')
    tc.assertNotEmpty(t)
    tc.verifyGreaterThan(strlength(t), 0)
  end
else
  tc.verifyEmpty(t)
end
end


function test_is_dev_drive(tc, B_ps)
[r, b] = stdlib.is_dev_drive(pwd(), B_ps);
tc.assertEqual(char(b), B_ps)

tc.verifyClass(r, 'logical')
end


function test_remove_file(tc)
tc.assumeFalse(stdlib.matlabOlderThan('R2018a'), 'test shaky on Matlab < R2018a')

f = 'test_remove.tmp';

tc.verifyFalse(stdlib.remove(f), 'should not succeed at removing non-existant path')

tc.assertTrue(stdlib.touch(f))
tc.assertThat(f, matlab.unittest.constraints.IsFile)

tc.verifyTrue(stdlib.remove(f))
end


function test_device(tc, Ps, B_jps)
[i, b] = stdlib.device(Ps, B_jps);
tc.verifyClass(i, 'uint64')
tc.assertEqual(char(b), B_jps)

if ismember(B_jps, stdlib.Backend().select('device'))
  if ~stdlib.exists(Ps)
    tc.verifyEmpty(i)
  else
    tc.assertNotEmpty(i)
    tc.assertGreaterThan(i, 0)
  end
else
  tc.assertEmpty(i)
end
end


function test_inode(tc, Ps, B_jps)

[i, b] = stdlib.inode(Ps, B_jps);
tc.verifyClass(i, 'uint64')
tc.assertEqual(char(b), B_jps)

if ismember(B_jps, stdlib.Backend().select('inode'))
  if ~stdlib.exists(Ps)
    tc.verifyEmpty(i)
  else
    tc.assertNotEmpty(i)
    tc.assertGreaterThan(i, 0)
  end
else
  tc.assertEmpty(i)
end

end


function test_owner(tc, Ps, B_jdps)
[o, b] = stdlib.get_owner(Ps, B_jdps);
tc.assertEqual(char(b), B_jdps)
tc.verifyClass(o, 'char')

if ismember(B_jdps, stdlib.Backend().select('get_owner'))
  if ~stdlib.exists(Ps)
    tc.verifyEqual(o, '')
  else
    tc.verifyGreaterThan(strlength(o), 0)
  end
else
  tc.verifyEmpty(o)
end

end


end
end
