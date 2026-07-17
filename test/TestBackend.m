% These tests are to ensure graceful degradation with missing (or no)
% available backends. Ideally, run this test with all these disabled
% * Java: matlab -nojvm
% * dotnet: setenv('DOTNET_ROOT') right upon starting Matlab on non-Windows system
% * python: seems one needs a Matlab install that never had Python setup.
% *   Alternative: install a temporary Python environment, set pyenv to that, then delete that Python install

classdef (TestTags = {'impure'}) TestBackend < WorkingClassDir

properties
root = fileparts(fileparts(mfilename('fullpath')))
end

methods (Test)
function test_backend(tc)
% check that auto backend selection works
import matlab.unittest.constraints.IsSubsetOf

readme = fullfile(tc.root, 'Readme.md');

tc.assertThat(readme, matlab.unittest.constraints.IsFile)

[i, b] = stdlib.cpu_load();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('cpu_load').backends))
tc.verifyGreaterThanOrEqual(i, 0, "failed with backend " + b)
% some CI systems report 0

% best to use full path to avoid issues on HPC etc.
sym_fn = fullfile(pwd(), 'Readme.lnk');
[i, b] = stdlib.create_symlink(readme, sym_fn);
tc.assertThat(b, IsSubsetOf(stdlib.Backend('create_symlink').backends))
tc.verifyTrue(i,  "could not create_symlink " + sym_fn + " -> " + readme + " with backend " + b)

[i, b] = stdlib.device('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('device').backends))
tc.verifyGreaterThan(i, 0, "failed with backend " + b)

[i, b] = stdlib.disk_available('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('disk_available').backends))
tc.verifyGreaterThan(i, 0, "failed with backend " + b)

[i, b] = stdlib.disk_capacity('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('disk_capacity').backends))
tc.verifyGreaterThan(i, 0, "failed with backend " + b)

[i, b] = stdlib.file_checksum(readme, 'sha256');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('file_checksum').backends))
tc.verifyEqual(strlength(i), 64, "failed with backend " + b)

[i, b] = stdlib.filesystem_type('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('filesystem_type').backends))
tc.verifyGreaterThan(strlength(i), 0, "failed with backend " + b)

[i, b] = stdlib.get_max_open_files();
if ~ismissing(i)
  tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_max_open_files').backends))
  tc.verifyGreaterThan(i, 0, "failed with backend " + b)
end

[i, b] = stdlib.get_owner('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_owner').backends))
tc.verifyGreaterThan(strlength(i), 0, "failed with backend " + b)

[i, b] = stdlib.get_process_priority();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_process_priority').backends))
tc.verifyNotEqual(i, missing, "failed with backend " + b)

[i, b] = stdlib.get_uid();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_uid').backends))
tc.verifyNotEqual(i, missing, "failed with backend " + b)

[i, b] = stdlib.get_username();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('get_username').backends))
tc.verifyClass(i, 'char', "failed with backend " + b)

[i, b] = stdlib.hard_link_count('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('hard_link_count').backends))
tc.verifyGreaterThan(i, 0, "failed with backend " + b)

[i, b] = stdlib.hostname();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('hostname').backends))
tc.verifyClass(i, 'char', "failed with backend " + b)

[i, b] = stdlib.inode(readme);
tc.assertThat(b, IsSubsetOf(stdlib.Backend('inode').backends))
tc.verifyThat(string(class(i)), IsSubsetOf(["uint64", "string"]), "failed with backend " + b)

[i,b] = stdlib.is_admin();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_admin').backends))
tc.verifyClass(i, 'logical', "failed with backend " + b)

[i,b] = stdlib.is_char_device('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_char_device').backends));
tc.verifyClass(i, 'logical', "failed with backend " + b)

[i, b] = stdlib.is_dev_drive('.');
if ~ismissing(i)
  tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_dev_drive').backends))
  tc.verifyClass(i, 'logical', "failed with backend " + b)
end

[i, b] = stdlib.is_mount('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_mount').backends))
tc.verifyClass(i, 'logical', "failed with backend " + b)

[i, b] = stdlib.is_removable('.');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_removable').backends))
tc.verifyClass(i, 'logical', "failed with backend " + b)

[i, b] = stdlib.is_symlink(readme);
tc.assertThat(b, IsSubsetOf(stdlib.Backend('is_symlink').backends))
tc.verifyClass(i, 'logical', "failed with backend " + b)

[os, version, b] = stdlib.os_version();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('os_version').backends))
tc.verifyClass(os, 'char', "failed with backend " + b)
tc.verifyClass(version, 'char', "failed with backend " + b)

[i, b] = stdlib.ram_free();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('ram_free').backends))
tc.verifyGreaterThan(i, 0, "failed with backend " + b)

[i, b] = stdlib.ram_total();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('ram_total').backends))
tc.verifyGreaterThan(i, 0, "failed with backend " + b)

[i, b] = stdlib.read_symlink('Readme.lnk');
tc.assertThat(b, IsSubsetOf(stdlib.Backend('read_symlink').backends))
tc.assertThat(i, matlab.unittest.constraints.IsFile, "failed with backend " + b)

[i, b] = stdlib.samepath(readme, readme);
tc.assertThat(b, IsSubsetOf(stdlib.Backend('samepath').backends))
tc.verifyTrue(i, "failed with backend " + b)

test_file = 'time.txt';
tc.assertTrue(stdlib.touch(test_file))
[i, b] = stdlib.set_modtime(test_file, datetime());
tc.assertThat(b, IsSubsetOf(stdlib.Backend('set_modtime').backends))
tc.verifyTrue(i, "failed with backend " + b)

[i, b] = stdlib.uptime();
tc.assertThat(b, IsSubsetOf(stdlib.Backend('uptime').backends))
tc.verifyGreaterThan(i, 0, "failed with backend " + b)


end

end


end
