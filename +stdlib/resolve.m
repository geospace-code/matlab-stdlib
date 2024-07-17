function c = resolve(p)
%% resolve(p)
% path need not exist--absolute path will be relative to pwd if not exist
% if path exists, same result as canonical()
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
% This also resolves Windows short paths to full long paths.
%
%%% Inputs
% * p: path to resolve
%%% Outputs
% * c: resolved path
% distinct from canonical(), resolve() always returns absolute path
% non-existant path is made absolute relative to pwd
arguments
  p (1,1) string
end

import java.io.File

% have to expand ~ first (like C++ filesystem::path::absolute)
c = stdlib.expanduser(p);

if ispc && startsWith(c, "\\")
  % UNC path is not canonicalized
  return
end

if ~stdlib.is_absolute(c)
  % .toAbsolutePath() default is Documents/Matlab, which is probably not wanted.
  c = stdlib.join(pwd, c);
end

% % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getCanonicalPath()

c = stdlib.posix(File(c).getCanonicalPath());

end % function
