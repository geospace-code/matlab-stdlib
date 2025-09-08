% These tests are to ensure graceful degradation with missing (or no)
% available backends. Ideally, run this test with all these disabled
% * Java: matlab -nojvm
% * dotnet: setenv('DOTNET_ROOT') right upon starting Matlab on non-Windows system
% * python: seems one needs a Matlab install that never had Python setup.
% *   Alternative: install a temporary Python environment, set pyenv to that, then delete that Python install

classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'impure'}) ...
    TestBackend < matlab.unittest.TestCase

properties
root = fileparts(fileparts(mfilename('fullpath')))
end

methods(TestClassSetup)
function test_dirs(tc)
  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end

methods (Test)
function test_backend(tc)
import matlab.unittest.constraints.IsSubsetOf
import matlab.unittest.constraints.IsFile

readme = tc.root + "/Readme.md";
tc.assertThat(readme, IsFile)

[i, b] = stdlib.cpu_load();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('cpu_load').backends))
tc.verifyGreaterThanOrEqual(i, 0)
% some CI systems report 0

[i, b] = stdlib.create_symlink(readme, "Readme.lnk");
tc.assertThat(b, IsSubsetOf(stdlib.Backend('create_symlink').backends))
tc.verifyTrue(i)

[i, b] = stdlib.device('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('device').backends))
tc.verifyGreaterThan(i, 0)

[i, b] = stdlib.disk_available('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('disk_available').backends))
tc.verifyGreaterThan(i, 0)

[i, b] = stdlib.disk_capacity('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('disk_capacity').backends))
tc.verifyGreaterThan(i, 0)

[i, b] = stdlib.file_checksum(readme, 'sha256');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('file_checksum').backends))
tc.verifyEqual(strlength(i), 64)

[i, b] = stdlib.filesystem_type('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('filesystem_type').backends))
tc.verifyGreaterThan(strlength(i), 0)

[i, b] = stdlib.get_owner('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_owner').backends))
tc.verifyGreaterThan(strlength(i), 0)

[i, b] = stdlib.get_process_priority();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_process_priority').backends))
tc.verifyNotEmpty(i)

[i, b] = stdlib.get_uid();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_uid').backends))
tc.verifyGreaterThanOrEqual(i, 0)

[i, b] = stdlib.get_username();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_username').backends))
tc.verifyNotEmpty(i)

[i, b] = stdlib.hard_link_count('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('hard_link_count').backends))
tc.verifyGreaterThan(i, 0)

[i, b] = stdlib.hostname();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('hostname').backends))
tc.verifyNotEmpty(i)

[i, b] = stdlib.inode(readme);
tc.assertThat(b, IsSubsetOf(stdlib.Backend('inode').backends))
tc.verifyGreaterThan(i, 0)

[i,b] = stdlib.is_admin();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_admin').backends))
tc.verifyNotEmpty(i)

[i,b] = stdlib.is_char_device('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_char_device').backends));
tc.verifyNotEmpty(i);

[i, b] = stdlib.is_dev_drive('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_dev_drive').backends))
tc.verifyNotEmpty(i)

[i, b] = stdlib.is_mount('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_mount').backends))
tc.verifyNotEmpty(i)

[i, b] = stdlib.is_removable('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_removable').backends))
tc.verifyNotEmpty(i)

[i, b] = stdlib.is_symlink(readme);
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_symlink').backends))
tc.verifyClass(i, 'logical')
tc.verifyNotEmpty(i)

[os, version, b] = stdlib.os_version();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('os_version').backends))
tc.verifyNotEmpty(os)
tc.verifyNotEmpty(version)

[i, b] = stdlib.ram_free();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('ram_free').backends))
tc.verifyGreaterThan(i, 0)

[i, b] = stdlib.ram_total();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('ram_total').backends))
tc.verifyGreaterThan(i, 0)

[i, b] = stdlib.read_symlink('Readme.lnk');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('read_symlink').backends))
tc.verifyThat(i, IsFile)

[i, b] = stdlib.samepath(readme, readme);
tc.assertThat(b, IsSubsetOf(stdlib.Backend('samepath').backends))
tc.verifyTrue(i)

[i, b] = stdlib.set_modtime("nobody", datetime());
tc.assertThat(b, IsSubsetOf(stdlib.Backend('set_modtime').backends))
tc.verifyNotEmpty(i)


end

end


end
