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
% * b: backend used

function [c, b] = canonical(p, strict)
arguments
  p string
  strict (1,1) logical = false
end

try
  c = stdlib.native.canonical(p, strict);
  b = 'native';
catch e
  switch e.identifier
    case {'MATLAB:UndefinedFunction', 'MATLAB:undefinedVarOrClass'}
      c = stdlib.legacy.canonical(p, strict);
      b = 'legacy';
    otherwise
      rethrow(e)
  end
end

end
