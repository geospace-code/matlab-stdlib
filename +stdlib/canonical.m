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

function c = canonical(p, expand_tilde)
arguments
  p (1,1) string
  expand_tilde (1,1) logical = true
end


if expand_tilde
  e = stdlib.expanduser(p);
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
else
% errors if any component of path does not exist.
% disp("builtin")
  try %#ok<TRYNC>
    c = builtin('_canonicalizepath', e);
  end
end

if ~stdlib.len(c)
  c = stdlib.normalize(e);
end

c = stdlib.posix(c);

end

%!assert(canonical("", 1), "")
%!assert(canonical("~", 1), homedir())
