function c = canonical(p, expand_tilde, use_java)
%% canonical(p)
% If exists, canonical absolute path is returned
% if path does not exist, normalized relative path is returned
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
% This also resolves Windows short paths to full long paths.
%
%%% Inputs
% * p: path to make canonical
% * expand_tilde: expand ~ to username if present
%%% Outputs
% * c: canonical path, if determined
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getCanonicalPath()
arguments
  p (1,1) string
  expand_tilde (1,1) logical = true
  use_java (1,1) logical = false
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

e = stdlib.exists(c);

if ~stdlib.is_absolute(c)
  if e
    if ~expand_tilde && ~use_java && startsWith(c, "~")
      c = stdlib.normalize(c, use_java);
      return
    else
      % workaround Java/Matlab limitations
      c = stdlib.join(pwd, c);
    end
  else
    % for non-existing path, return normalized relative path
    % like C++ filesystem weakly_canonical()
    c = stdlib.normalize(c, use_java);
    return
  end
end

if use_java
  c = java.io.File(c).getCanonicalPath();
elseif e
  % errors if path does not exist. Errors on leading ~
  c = builtin('_canonicalizepath', c);
else
  c = stdlib.normalize(c, use_java);
end

c = stdlib.posix(c);

end % function
