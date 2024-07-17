function exe = which(filename, fpath)
%% which()
% like Python shutil.which, find executable in fpath or env var PATH
% does not resolve path.
% That is, can return relative path if executable is in:
% * (Windows) in cwd
% * (all) fpath or Path contains relative paths
arguments
  filename (1,1) string {mustBeNonzeroLengthText}
  fpath (1,:) string = getenv('PATH')
end

names = filename;

if ispc
  % Windows executable filename doesn't necessarily need .exe,
  % particularly for WSL executables that is_exe() will detect from
  % native Windows Matlab.
  if ~endsWith(lower(filename), ".exe")
    names(2) = filename + ".exe";
  end
end

% directory/filename given
for exe = names

  if stdlib.is_absolute(exe) && stdlib.is_exe(exe)
    return
  end

end % for exe

% path given

if isscalar(fpath)
  % PATH could have ~/ prefixed paths in it
  fpath = split(stdlib.expanduser(fpath), pathsep).';
end
fpath = fpath(strlength(fpath)>0);

if ispc
  % windows pwd priority, while unix ignores
  fpath = [pwd, fpath];
end

for name = names

  for p = fpath
    exe = stdlib.join(p, name);
    if stdlib.is_exe(exe)
      return
    end
  end

end % for name

exe = string.empty;

end
