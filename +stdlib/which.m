%% WHICH find executable in fpath or env var PATH
% like Python shutil.which, find executable in fpath or env var PATH
% does not resolve path.
% That is, can return relative path if executable is in:
% * (Windows) in cwd
% * (all) fpath or Path contains relative paths
%
% find_all option finds all executables specified under PATH, instead of only the first

function exe = which(filename, fpath, find_all)
arguments
  filename {mustBeTextScalar}
  fpath (1,:) string = string.empty
  find_all (1,1) logical = false
end

if find_all
  exe = string.empty;
else
  exe = '';
end

if isfile(filename) && stdlib.is_exe(filename)
  exe = filename;
  return
end

%  relative directory component, but path was not a file
if ~strcmp(stdlib.filename(filename), filename)
  return
end

% path given
if isempty(fpath)
  fpath = getenv("PATH");
end

if isscalar(fpath) || ischar(fpath)
  fpath = strsplit(fpath, pathsep);
end

for fp = fpath
  if iscell(fp)
    p = fp{1};
  else
    p = fp;
  end

  if strempty(p), continue, end

  e = strcat(p, '/', filename);
  if isfile(e) && stdlib.is_exe(e)
    if find_all
      exe(end+1) = e; %#ok<AGROW>
    else
      exe = e;
      return
    end
  end
end

end

%!assert(~isempty(which("octave", [], false)))
