%% CANONICAL Canonicalize path
% c = canonical(p);
% If exists, canonical absolute path is returned.
% if any component of path does not exist, normalized relative path is returned.
% UNC paths are not canonicalized.
%
% This also resolves Windows short paths to long paths.
%
%%% Inputs
% * file: path to make canonical
% * strict: if true, only return canonical path if it exists. If false, return normalized path if path does not exist.
%%% Outputs
% * c: canonical path, if determined

function c = canonical(file, strict)
if nargin < 2
  strict = false;
end

if stdlib.strempty(file)
  c = extractBefore(file, 1);
  return
end

[s, r] = fileattrib(file);

if s == 1
  c = r.Name;
elseif ~strict
  c = stdlib.normalize(file);
else
  c = extractBefore(file, 1);
end

end
