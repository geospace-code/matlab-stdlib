%% LIBRARY_VERSION get version of shared library
% general example of access shared library version info from Matlab
% using loadlibrary() to call a function in a shared library without a MEX file.
%
% Input:
%   libPath - Full path to the library (optional)
%
% Output:
%   v - version string (e.g., '1.9.0')

function v = library_version(libPath, header, name)
arguments
  libPath {mustBeTextScalar, mustBeFile}
  header {mustBeTextScalar, mustBeFile}
  name {mustBeTextScalar}
end


if ispc()
  % Windows .NET
  fileInfo = System.Diagnostics.FileVersionInfo.GetVersionInfo(libPath);
  v = char(fileInfo.FileVersion);
else
% elseif ismac()
%   cmd = ['otool -L "' char(libPath) '"'];
%   pat = '(?<=current version\s+)[0-9][0-9.]+';
%   v = shell_regex(cmd, pat);

  if ~libisloaded(name)
    if isfile(libPath)
      loadlibrary(libPath, header, alias=name);
    else
      v = missing;
      return
    end
  end

  switch name
    case 'git2'
      fun = 'git_libgit2_version';
    otherwise
      error('stdlib:library_version', 'Unknown library name: %s', name)
  end

  maj = libpointer('int32Ptr', 0);
  min = libpointer('int32Ptr', 0);
  rev = libpointer('int32Ptr', 0);

  calllib(name, fun, maj, min, rev);
  v = sprintf('%d.%d.%d', maj.Value, min.Value, rev.Value);

  unloadlibrary(name)
end


end
