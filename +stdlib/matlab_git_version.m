%% MATLAB_GIT_VERSION version of the Git2 library used by Matlab
% version('-modules') doesn't reveal the version of Git2, so this function uses
% loadlibrary() to call a function in the Git2 library without a MEX file.
%
% Input:
%   libPath - Full path to the library (optional)
%
% Output:
%   v - version string (e.g., '1.9.0')

function v = matlab_git_version(libPath)
arguments
  libPath {mustBeTextScalar} = getMatlabGit2libPath()
end

v = library_version(libPath, fullfile(fileparts(mfilename("fullpath")), 'private/git2dummy.h'), 'git2');

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
