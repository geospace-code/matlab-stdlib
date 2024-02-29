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
  if isfile(c) || isfolder(c)
    % workaround Java/Matlab limitations
    c = stdlib.fileio.join(pwd, c);
  else
    % for non-existing path, return normalized relative path
    % like C++ filesystem weakly_canonical()
    c = stdlib.fileio.normalize(c);
    return
  end
end

% similar benchmark time as java method
% REQUIRES path to exist, while java method does not.
% c = builtin('_canonicalizepath', c);

% https://docs.oracle.com/javase/9/docs/api/java/io/File.html#getCanonicalPath--

c = stdlib.fileio.posix(string(java.io.File(c).getCanonicalPath()));

end % function
