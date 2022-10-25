function exe = which(filename, fpath)
%% which(filename, fpath)
% Find executable with name under path
% like Python shutil.which, may return relative or absolute path

arguments
  filename (1,1) string {mustBeNonzeroLengthText}
  fpath (1,:) string = getenv('PATH')
end

names = filename;

if ispc
  % Windows executable filename doesn't necessarily need .exe,
  % particularly for WSL executables that is_exe() will detect from
  % native Windows Matlab.
  if ~endsWith(filename, ".exe")
    names(2) = filename + ".exe";
  end
end

%% directory/filename given
for name = names

  if strlength(fileparts(name)) > 0
    % has directory part
    if stdlib.fileio.is_exe(name)
      exe = name;
      return
    end
  end

end % for name

%% path given

if isscalar(fpath)
  fpath = split(stdlib.fileio.expanduser(fpath), pathsep).';
end
fpath = fpath(strlength(fpath)>0);

if ispc
  % windows pwd priority, while unix ignores
  fpath = [pwd, fpath];
end

for name = names

  for p = fpath
    exe = fullfile(p, name);
    if stdlib.fileio.is_exe(exe)
      return
    end
  end

end % for name

exe = string.empty;

end
