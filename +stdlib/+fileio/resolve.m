function c = resolve(p)
% distinct from canonical(), resolve() always returns absolute path
% non-existant path is made absolute relative to pwd
arguments
  p string {mustBeScalarOrEmpty}
end

% have to expand ~ first (like C++ filesystem::path::absolute)
c = stdlib.fileio.expanduser(p);

if isempty(c)
  return
end

if ispc && startsWith(c, "\\")
  % UNC path is not canonicalized
  return
end

if ~stdlib.fileio.is_absolute_path(c)
  % .toAbsolutePath() default is Documents/Matlab, which is probably not wanted.
  c = fullfile(pwd, c);
end

% similar benchmark time as java method
% REQUIRES path to exist, while java method does not.
% c = builtin('_canonicalizepath', c);

% https://docs.oracle.com/javase/9/docs/api/java/io/File.html#getCanonicalPath--

c = stdlib.fileio.posix(string(java.io.File(c).getCanonicalPath()));

end % function
