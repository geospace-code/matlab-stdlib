%% CANONICAL Canonicalize path
% c = canonical(p);
% If exists, canonical absolute path is returned.
% if any component of path does not exist, normalized relative path is returned.
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
  e = stdlib.expanduser(p, use_java);
else
  e = p;
end

c = "";

if ~stdlib.len(e), return, end

if ispc && (startsWith(e, "\\") || startsWith(e, "//"))
  % UNC path is not canonicalized
  return
end

if stdlib.isoctave()
% empty if any component of path does not exist
  c = canonicalize_file_name(e);
elseif use_java && stdlib.is_absolute(e, true)
% incorrect result if relative path and any component of path does not exist
% disp("java")
  c = javaFileObject(e).getCanonicalPath();
else
% errors if any component of path does not exist.
% disp("builtin")
  try %#ok<TRYNC>
    c = builtin('_canonicalizepath', e);
  end
end

if ~stdlib.len(c)
  c = stdlib.normalize(e, use_java);
end

c = stdlib.posix(c);

end

%!assert(canonical("", 1, 0), "")
%!assert(canonical("~", 1, 0), homedir())
%!assert(canonical("a/b/..", 1, 0), "a")
