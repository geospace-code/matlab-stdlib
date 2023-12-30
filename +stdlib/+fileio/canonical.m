function c = canonical(p)

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
% abspath = builtin('_canonicalizepath', abspath);

c = string(java.io.File(c).getCanonicalPath());

end % function
