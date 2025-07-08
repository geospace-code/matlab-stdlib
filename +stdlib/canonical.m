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

try
  pth = matlab.io.internal.filesystem.resolvePath(p);
  c = pth.ResolvedPath;
  if strempty(c)
    c = stdlib.normalize(p);
  end
catch e
  if strcmp(e.identifier, 'MATLAB:undefinedVarOrClass') || startsWith(e.message, 'member')
    c = acanon(p);
  else
    rethrow(e)
  end
end

c = string(c);

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
