function c = resolve(p, expand_tilde)
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
  expand_tilde (1,1) logical=true
end

if expand_tilde
  c = stdlib.expanduser(p);
else
  c = p;
end

if ispc && startsWith(c, "\\")
  % UNC path is not canonicalized
  return
end

if ~stdlib.is_absolute(c)
  % .toAbsolutePath() default is Documents/Matlab, which is probably not wanted.
  c = stdlib.join(pwd, c);
end

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getAbsolutePath()

c = stdlib.posix(java.io.File(java.io.File(c).getAbsolutePath()).toPath().normalize());

end % function
