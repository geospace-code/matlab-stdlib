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
%%% Outputs
% * c: canonical path, if determined

function c = canonical(p)
arguments
  p {mustBeTextScalar}
end

if strempty(p)
  c = '';
else
  [s, r] = fileattrib(p);

  if s == 1
    c = stdlib.posix(r.Name);
  else
    c = stdlib.normalize(p);
  end
end

if isstring(p)
  c = string(c);
end

end

%!assert(canonical(""), "")
%!assert(canonical("."), pwd())
