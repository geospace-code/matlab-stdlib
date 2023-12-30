function abspath = absolute_path(p)

arguments
  p string {mustBeScalarOrEmpty}
end

% have to expand ~ first (like C++ filesystem::path::absolute)
abspath = stdlib.fileio.expanduser(p);

if isempty(abspath)
  return
end

if ispc && startsWith(abspath, "\\")
  % UNC path is not canonicalized
  return
end

if ~stdlib.fileio.is_absolute_path(abspath)
  % .toAbsolutePath() default is Documents/Matlab, which is probably not wanted.
  abspath = fullfile(pwd, abspath);
end

abspath = string(java.io.File(abspath).getAbsolutePath());

end % function
