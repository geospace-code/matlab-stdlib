function exe = which(name, fpath, subdir)
% fileio.which Find executable with name under path
% like Python shutil.which, may return relative or absolute path

arguments
  name (1,1) string {mustBeNonzeroLengthText}
  fpath string = getenv('PATH')
  subdir (1,:) string {mustBeNonempty} = ""
end

exe = string.empty;

if ispc
  pathext = ".exe";
  if ~endsWith(name, pathext)
    name = [name + pathext, name];
  end
end

if any(strlength(fileparts(name)) > 0)
  % has directory part
  for n = name
    if check_exe(n)
      exe = n;
      break
    end
  end
  return
end

fpath = split(stdlib.fileio.expanduser(fpath), pathsep).';
fpath = fpath(strlength(fpath)>0);

if ispc
  % windows pwd priority, while unix ignores
  fpath = [pwd, fpath];
end

for p = fpath
  for s = subdir
    for n = name
      e = fullfile(p, s, n);
      if check_exe(e)
        exe = e;
        return
      end
    end
  end

end

end


function ok = check_exe(exe)
arguments
  exe (1,1) string
end

[ok1, stat] = fileattrib(exe);
ok = ok1 == 1 && (stat.UserExecute == 1 || stat.GroupExecute == 1);

end
