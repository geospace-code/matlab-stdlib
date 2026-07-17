%% MATLAB_GIT_VERSION version of the Git2 library used by Matlab
% general example of access shared library version info from Matlab
%
% Input:
%   libPath - Full path to the library (optional)
%
% Output:
%   v - version string (e.g., '1.9.0')

function v = matlab_git_version(libPath)
arguments
  libPath {mustBeTextScalar, mustBeFile} = getMatlabGit2libPath()
end

if ispc()
  % Windows .NET
  fileInfo = System.Diagnostics.FileVersionInfo.GetVersionInfo(libPath);
  v = char(fileInfo.FileVersion);
  return
elseif ismac()
  cmd = ['otool -L "' char(libPath) '"'];
  pat = '(?<=current version\s+)[0-9][0-9.]+';
else
  % Linux
  cmd = ['strings "' char(libPath) '"'];
  pat = '[0-9]+\.[0-9]+\.[0-9]+';
end

[status, output] = system(cmd);
assert(status == 0, 'Failed to get library version from %s\nOutput: %s', cmd, output);

v = regexp(output, pat, 'match', 'once');
if iscell(v)
  v = v{1};
end
v = char(strtrim(v));

end


function p = getMatlabGit2libPath()
  archDir = fullfile(matlabroot, 'bin', computer('arch'));

  if ispc()
    p = fullfile(archDir, 'git2.dll');
  elseif ismac()
    p = fullfile(archDir, 'libgit2.dylib');
  else
    p = fullfile(archDir, 'libgit2.so');
    if isfile(p)
      return
    end

    % Possible patterns in order of preference
    patterns = ["libgit2.so.3.*", "libgit2.so.2.*", "libgit2.so.1.*", "libgit2.so.*"];

    for pat = patterns
      files = dir(fullfile(archDir, pat));
      if ~isempty(files)
        % Take the one with the most detailed version number (longest string)
        [~, idx] = max(strlength({files.name}));
        p = fullfile(archDir, files(idx).name);
        return
      end
    end
  end
end
