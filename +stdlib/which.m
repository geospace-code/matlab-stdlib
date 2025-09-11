%% WHICH find executable in fpath or env var PATH
% like Python shutil.which, find executable in fpath or env var PATH
% does not resolve path.
% That is, can return relative path if executable is in:
% * (Windows) in cwd
% * (all) fpath or Path contains relative paths
%
% find_all option finds all executables specified under PATH, instead of only the first

function exe = which(cmd, fpath, find_all)
arguments
  cmd (1,1) string
  fpath (1,:) string = string.empty
  find_all (1,1) logical = false
end

exe = string.empty;

%% on Windows, append .exe if not suffix is given
if ispc() && stdlib.strempty(stdlib.suffix(cmd))
  cmd = cmd + ".exe";
end
%% full filename was given
if stdlib.is_exe(cmd)
  % is_exe implies isfile
  exe = cmd;
  return
end

%  relative directory component, but path was not an executable file
if ~strcmp(stdlib.filename(cmd), cmd)
  return
end

% path given
if stdlib.strempty(fpath)
  fpath = string(getenv("PATH"));
end

if isscalar(fpath)
  fpath = split(fpath, pathsep).';
end

for p = fpath
  if stdlib.strempty(p), continue, end

  if endsWith(p, ["/", filesep])
    e = p + cmd;
  else
    e = p + "/" + cmd;
  end
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
