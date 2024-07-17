function c = canonical(p)
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
%%% Outputs
% * c: canonical path, if determined
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getCanonicalPath()
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
  if isfile(c) || isfolder(c)
    % workaround Java/Matlab limitations
    c = stdlib.join(pwd, c);
  else
    % for non-existing path, return normalized relative path
    % like C++ filesystem weakly_canonical()
    c = stdlib.normalize(c);
    return
  end
end

% similar benchmark time as java method
% REQUIRES path to exist, while java method does not.
% c = builtin('_canonicalizepath', c);

c = stdlib.posix(File(c).getCanonicalPath());

end % function
