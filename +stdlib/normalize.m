%% NORMALIZE remove redundant elements of path
%
% normalize(p) remove redundant elements of path p. Does not walk up ".." to be safe.
% Path need not exist. Does not access physical filesystem.
%
%%% Inputs
% * p: path to normalize
% * backend: backend to use
%%% Outputs
% * c: normalized path
% * b: backend used

function [n, b] = normalize(file, backend)
arguments
  file string
  backend (1,:) string = ["native", "python", "perl"]
end

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  n = o.func(file);
else
  n = arrayfun(o.func, file);
end

b = o.backend;


end
