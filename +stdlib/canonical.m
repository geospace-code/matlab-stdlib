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
  c = "";
  return
end

if stdlib.isoctave() || isMATLABReleaseOlderThan('R2024a')
  c = acanon(p);
else
  pth = matlab.io.internal.filesystem.resolvePath(p);
  c = pth.ResolvedPath;
  if strempty(c)
    c = stdlib.normalize(p);
  end
end

try %#ok<*TRYNC>
  c = string(c);
end

end


function c = acanon(p)

if strempty(p), c = ''; return, end

[s, r] = fileattrib(p);

if s == 1
  c = r.Name;
else
  c = stdlib.normalize(p);
end

end

%!assert(canonical(""), "")
%!assert(canonical("."), pwd())
