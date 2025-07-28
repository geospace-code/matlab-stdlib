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
% * strict: if true, only return canonical path if it exists. If false, return normalized path if path does not exist.
%%% Outputs
% * c: canonical path, if determined

function c = canonical(p, strict)
arguments
  p {mustBeTextScalar}
  strict logical = false
end

if stdlib.strempty(p)
  c = "";
  return
end

if isMATLABReleaseOlderThan('R2024a')
  c = acanon(p, strict);
else
  pth = matlab.io.internal.filesystem.resolvePath(p);
  c = pth.ResolvedPath;
  if ~strict && stdlib.strempty(c)
    c = stdlib.normalize(p);
  end
end

c = string(c);

end


function c = acanon(p, strict)

c = "";

if stdlib.strempty(p), return, end

[s, r] = fileattrib(p);

if s == 1
  c = r.Name;
elseif ~strict
  c = stdlib.normalize(p);
end

end
