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
% * backend: backend to use
%%% Outputs
% * c: canonical path, if determined
% * b: backend used

function [c, b] = canonical(p, strict, backend)
arguments
  p string
  strict (1,1) logical = false
  backend (1,:) string = ["native", "legacy"]
end

[fun, b] = hbackend(backend, "canonical");

if isscalar(p) || b == "native"
  c = fun(p, strict);
else
  c = arrayfun(fun, p, repmat(strict, size(p)));
end

end
