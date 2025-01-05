%% WHICH find executable in fpath or env var PATH
% like Python shutil.which, find executable in fpath or env var PATH
% does not resolve path.
% That is, can return relative path if executable is in:
% * (Windows) in cwd
% * (all) fpath or Path contains relative paths

function exe = which(filename, fpath, use_java)
arguments
  filename (1,1) string
  fpath (1,:) string = getenv('PATH')
  use_java (1,1) logical = false
end

exe = string.empty;

if isfile(filename) && stdlib.is_exe(filename, use_java)
  exe = stdlib.posix(filename);
  return
end

%  relative directory component, but path was not a file
if stdlib.filename(filename) ~= filename
  return
end

% path given

if isscalar(fpath)
  % PATH could have ~/ prefixed paths in it
  fpath = split(stdlib.expanduser(fpath), pathsep).';
end
fpath = fpath(strlength(fpath)>0);

for p = fpath
  e = p + "/" + filename;
  if isfile(e) && stdlib.is_exe(e, use_java)
    exe = stdlib.posix(e);
    return
  end
end

end

%!testif 0
