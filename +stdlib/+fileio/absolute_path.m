function abspath = absolute_path(p)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getAbsolutePath()
arguments
  p string {mustBeScalarOrEmpty}
end

% have to expand ~ first (like C++ filesystem::path::absolute)
abspath = stdlib.fileio.expanduser(p);

if isempty(abspath) || abspath == ""
  return
end

if ispc && startsWith(abspath, "\\")
  % UNC path is not canonicalized
  return
end

if ~stdlib.fileio.is_absolute_path(abspath)
  % .toAbsolutePath() default is Documents/Matlab, which is probably not wanted.
  abspath = stdlib.fileio.join(pwd, abspath);
end

abspath = stdlib.posix(java.io.File(abspath).getAbsolutePath());

end % function
