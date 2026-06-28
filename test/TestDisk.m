classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a'}) ...
  TestDisk < matlab.unittest.TestCase

properties
CI = is_ci()
end

properties (TestParameter)
Ps = {'.', '', '/', pwd(), getenv('SystemDrive'), 'not-exist'}
B_ps = {'python', 'shell'}
B_jps = {'java', 'python', 'shell'}
B_jdps = {'java', 'dotnet', 'python', 'shell'}
end

methods(TestClassSetup)
function test_dirs(tc)
  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture());
end
end

methods (Test)

function test_disk_available(tc, Ps, B_jdps)
[r, b] = stdlib.disk_available(Ps, B_jdps);
tc.assertMatches(b, B_jdps)

if ismember(B_jdps, stdlib.Backend().select('disk_available'))
  if stdlib.exists(Ps)
    tc.verifyClass(r, 'uint64')
    tc.verifyGreaterThanOrEqual(r, 0)
  else
    tc.verifyEqual(r, missing)
  end
else
  tc.verifyEqual(r, missing)
end

end


function test_disk_capacity(tc, Ps, B_jdps)
[r, b] = stdlib.disk_capacity(Ps, B_jdps);
tc.assertMatches(b, B_jdps)


if ismember(B_jdps, stdlib.Backend().select('disk_capacity'))
  if stdlib.exists(Ps)
   tc.verifyClass(r, 'uint64')
    tc.verifyGreaterThanOrEqual(r, 0)
  else
    tc.verifyEqual(r, missing)
  end
else
  tc.verifyEqual(r, missing)
end

end


function test_ulimit(tc, B_ps)
[i, b] = stdlib.get_max_open_files(B_ps);
tc.assertMatches(b, B_ps)
if ispc() || (B_ps == "python" && ~stdlib.has_python())
  tc.verifyEqual(i, missing)
else
  tc.verifyClass(i, 'uint64')
  tc.verifyGreaterThan(i, 0)
end
end


function test_is_removable(tc, B_ps)
[y, b] = stdlib.is_removable(pwd(), B_ps);
tc.assertMatches(b, B_ps)
if ~ismissing(y)
  tc.verifyClass(y, 'logical')
end
end

function test_is_mount(tc, B_ps)
[y,b] = stdlib.is_mount(pwd(), B_ps);
tc.assertMatches(b, B_ps)

if ismember(B_ps, stdlib.Backend().select('is_mount'))
  tc.verifyClass(y, 'logical')
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
  tc.verifyEqual(y, missing)
end
end


function test_hard_link_count(tc, B_jps)
fn = 'test_hard_link_count.txt';
tc.assertTrue(stdlib.touch(fn))

[i, b] = stdlib.hard_link_count(fn, B_jps);
tc.assertMatches(b, B_jps)

if ismember(B_jps, stdlib.Backend().select('hard_link_count'))
  tc.verifyGreaterThanOrEqual(i, 1)
else
  tc.assertEqual(i, missing)
end

i = stdlib.hard_link_count('');
  tc.verifyEqual(i, missing)
end


function test_filesystem_type(tc, Ps, B_jdps)
[t, b] = stdlib.filesystem_type(Ps, B_jdps);
tc.assertMatches(b, B_jdps)

if ismember(B_jdps, stdlib.Backend().select('filesystem_type'))
  if ~stdlib.exists(Ps)
    tc.verifyEqual(t, missing)
  else
    tc.verifyClass(t, 'char')
    tc.assumeFalse(any(ismissing(t)) && tc.CI, 'Some CI block viewing their filesystem type')
    tc.verifyGreaterThan(strlength(t), 0)
  end
else
  tc.verifyEqual(t, missing)
end
end


function test_is_dev_drive(tc, B_ps)
[r, b] = stdlib.is_dev_drive(pwd(), B_ps);
tc.assertMatches(b, B_ps)
if ~ismissing(r)
  tc.verifyClass(r, 'logical')
end
end


function test_remove_file(tc)
f = 'test_remove.tmp';

tc.verifyFalse(stdlib.remove(f), 'should not succeed at removing non-existant path')

tc.assertTrue(stdlib.touch(f))
tc.assertThat(f, matlab.unittest.constraints.IsFile)

tc.verifyTrue(stdlib.remove(f))
end


function test_device(tc, Ps, B_jps)
if ~stdlib.exists(Ps)
  tc.verifyError(@() stdlib.device(Ps, B_jps), 'MATLAB:validators:mustBeFileOrFolder')
else
  [i, b] = stdlib.device(Ps, B_jps);
  if ismember(B_jps, stdlib.Backend().select('device'))
    tc.verifyClass(i, 'uint64')
    tc.verifyMatches(b, B_jps)
    tc.assertNotEmpty(i, Ps)
    tc.assertGreaterThan(i, 0)
  else
    tc.verifyEqual(i, missing)
  end
end
end


function test_inode(tc, Ps, B_jps)

if ~stdlib.exists(Ps)
  tc.verifyError(@() stdlib.inode(Ps, B_jps), 'MATLAB:validators:mustBeFileOrFolder')
else
  [i, b] = stdlib.inode(Ps, B_jps);
  if ismember(B_jps, stdlib.Backend().select('inode'))
    tc.verifyClass(i, 'uint64')
    tc.verifyMatches(b, B_jps)
    tc.assertNotEmpty(i, Ps)
    tc.assertGreaterThan(i, 0)
  else
    tc.verifyEqual(i, missing)
  end
end

end


function test_owner(tc, Ps, B_jdps)

if ~stdlib.exists(Ps)
  tc.verifyError(@() stdlib.get_owner(Ps, B_jdps), 'MATLAB:validators:mustBeFileOrFolder')
else

[o, b] = stdlib.get_owner(Ps, B_jdps);
tc.assertMatches(b, B_jdps)

if ismember(B_jdps, stdlib.Backend().select('get_owner'))
  if ~stdlib.exists(Ps)
    tc.verifyEqual(o, missing)
  else
  tc.verifyClass(o, 'char')
    tc.verifyGreaterThan(strlength(o), 0)
  end
else
  tc.verifyEqual(o, missing)
end

end % stdlib.exists

end


end
end
