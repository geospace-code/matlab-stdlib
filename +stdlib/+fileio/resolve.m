function c = resolve(p)
% distinct from canonical(), resolve() always returns absolute path
% non-existant path is made absolute relative to pwd
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
  % .toAbsolutePath() default is Documents/Matlab, which is probably not wanted.
  c = stdlib.fileio.join(pwd, c);
end

% % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getCanonicalPath()

c = stdlib.fileio.posix(File(c).getCanonicalPath());

end % function
