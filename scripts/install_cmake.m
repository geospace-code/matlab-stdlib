%% INSTALL_CMAKE downloads and extracts a specific version of CMake for the
% current platform.
%
%   install_cmake(prefix, version)
%
%   Inputs:
%       prefix: The destination path to install CMake.
%       version: The version number of CMake to download (e.g., '3.29.3').
%
%   The script will download the appropriate CMake archive and extract it
%   into a subfolder within the specified prefix. It then prints the necessary
%   PATH modification to the command window.

function install_cmake(prefix, cmake_version)
arguments
  prefix (1,1) string
  cmake_version (1,1) string
end

stub = '';
ext = ".tar.gz";
name_arch = '';

if ispc()
  os = 'windows';
  switch getenv('PROCESSOR_ARCHITECTURE')
    case 'ARM64', name_arch = 'arm64';
    case 'AMD64', name_arch = 'x86_64';
  end
  ext = ".zip";
elseif ismac()
  os = 'macos';
  name_arch = 'universal';
  stub = 'CMake.app/Contents/';
elseif isunix()
  os = 'linux';
  [s, m] = system('uname -m');
  assert(s==0, "could not determine CPU architecture")
  switch m
    case {'aarch64', 'arm64'}, name_arch = 'aarch64';
    case 'x86_64', name_arch = 'x86_64';
  end
end
mustBeNonempty(name_arch)

% Compose the URL for the download.
archive_name = sprintf('cmake-%s-%s-%s', cmake_version, os, name_arch);
archive_file = archive_name + ext;
archive_path = fullfile(prefix, archive_file);
url = sprintf('https://github.com/Kitware/CMake/releases/download/v%s/%s', cmake_version, archive_file);

fprintf('%s => %s\n', url, archive_path);
if ~isfolder(prefix)
  mkdir(prefix);
end
websave(archive_path, url);

% Extract the archive based on its type.
dest_dir = fullfile(prefix, archive_name);
fprintf('Extracting to %s\n', dest_dir);
switch ext
  case ".zip"
    unzip(archive_path, prefix);
  case ".tar.gz"
    untar(archive_path, prefix);
end
delete(archive_path);

disp("Installation complete in " + prefix)

newpath = fullfile(dest_dir, stub, 'bin');
if isunix()
  disp("Please add the following line to your shell configuration file (e.g., .bashrc, .zshrc, .profile) to update your PATH:")
  fprintf('  export PATH="%s":$PATH\n', newpath);
else
  disp("Please add to user environment variable PATH")
  disp(newpath)
end

end
