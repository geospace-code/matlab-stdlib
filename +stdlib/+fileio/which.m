function exe = which(name, fpath)
% fileio.which Find executable with name under path
% like Python shutil.which, may return relative or absolute path

arguments
  name (1,1) string {mustBeNonzeroLengthText}
  fpath (1,:) string = getenv('PATH')
end

import stdlib.fileio.is_exe
import stdlib.fileio.expanduser

if ispc
  pathext = ".exe";
  if ~endsWith(name, pathext)
    name = name + pathext;
  end
end

if strlength(fileparts(name)) > 0
  % has directory part
  if is_exe(name)
    exe = name;
    return
  end
end

if isscalar(fpath)
  fpath = split(expanduser(fpath), pathsep).';
end
fpath = fpath(strlength(fpath)>0);

if ispc
  % windows pwd priority, while unix ignores
  fpath = [pwd, fpath];
end

for p = fpath
  exe = fullfile(p, name);
  if is_exe(exe)
    return
  end
end

exe = string.empty;

end
