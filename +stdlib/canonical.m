%% CANONICAL Canonicalize path
% c = canonical(p);
% If exists, canonical absolute path is returned.
% if path does not exist, normalized relative path is returned.
% UNC paths are not canonicalized.
%
% This also resolves Windows short paths to long paths.
%
%%% Inputs
% * p: path to make canonical
% * expand_tilde: expand ~ to username if present
%%% Outputs
% * c: canonical path, if determined
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getCanonicalPath()

function c = canonical(p, expand_tilde, use_java)
arguments
  p (1,1) string
  expand_tilde (1,1) logical = true
  use_java (1,1) logical = false
end


if expand_tilde
  c = stdlib.expanduser(p, use_java);
else
  c = p;
end

if ~stdlib.len(c)
  return
end

if ispc && startsWith(c, "\\")
  % UNC path is not canonicalized
  return
end

if stdlib.exists(c, use_java)
  if stdlib.isoctave()
    c = canonicalize_file_name(c);
  else
    % errors if path does not exist. Errors on leading ~
    c = builtin('_canonicalizepath', c);
  end

  c = stdlib.posix(c);
  return
end

% like C++ filesystem weakly_canonical()

if use_java
  c = javaFileObject(c).getCanonicalPath();
else
  c = stdlib.normalize(c, use_java);
end

c = stdlib.posix(c);

end

%!assert(canonical("", 1, 0), "")
%!assert(canonical("~", 1, 0), homedir())
%!assert(canonical("a/b/..", 1, 0), "a")
