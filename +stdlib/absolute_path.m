function abspath = absolute_path(p)
%% absolute_path(p)
% path need not exist, but absolute path is returned
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
%%% Inputs
% * p: path to make absolute
%%% Outputs
% * a: absolute path, if determined
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getAbsolutePath()
arguments
  p (1,1) string
end

% have to expand ~ first (like C++ filesystem::path::absolute)
abspath = stdlib.expanduser(p);

if abspath == ""
  return
end

if ispc && startsWith(abspath, "\\")
  % UNC path is not canonicalized
  return
end

if ~stdlib.is_absolute(abspath)
  % .toAbsolutePath() default is Documents/Matlab, which is probably not wanted.
  abspath = stdlib.join(pwd, abspath);
end

abspath = stdlib.posix(java.io.File(abspath).getAbsolutePath());

end % function
