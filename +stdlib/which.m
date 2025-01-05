%% WHICH find executable in fpath or env var PATH
% like Python shutil.which, find executable in fpath or env var PATH
% does not resolve path.
% That is, can return relative path if executable is in:
% * (Windows) in cwd
% * (all) fpath or Path contains relative paths
%
% find_all option finds all executables specified under PATH, instead of only the first

function exe = which(filename, fpath, find_all, use_java)
arguments
  filename (1,1) string
  fpath (1,:) string = string.empty
  find_all (1,1) logical = false
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
if isempty(fpath) || strlength(fpath) == 0
  fpath = string(getenv("PATH"));
end

if isscalar(fpath)
  fpath = split(fpath, pathsep);
end
fpath = fpath(strlength(fpath)>0);

for p = fpath.'
  e = p + "/" + filename;
  if isfile(e) && stdlib.is_exe(e, use_java)
    if find_all
      exe(end+1) = stdlib.posix(e); %#ok<AGROW>
    else
      exe = stdlib.posix(e);
      return
    end
  end
end

end

%!testif 0
