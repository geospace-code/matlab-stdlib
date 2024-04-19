function c = canonical(p)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getCanonicalPath()
arguments
  p (1,1) string
end

import java.io.File

% have to expand ~ first (like C++ filesystem::path::absolute)
c = stdlib.fileio.expanduser(p);

if ispc && startsWith(c, "\\")
  % UNC path is not canonicalized
  return
end

if ~stdlib.fileio.is_absolute(c)
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

c = stdlib.fileio.posix(File(c).getCanonicalPath());

end % function
