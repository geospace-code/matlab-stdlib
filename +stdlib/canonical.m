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

function c = canonical(p, strict, method)
arguments
  p {mustBeTextScalar}
  strict (1,1) logical = false
  method (1,:) string = ["native", "legacy"]
end

fun = choose_method(method, "canonical", 'R2024a');

c = fun(p, strict);

end
