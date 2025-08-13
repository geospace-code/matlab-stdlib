%% NORMALIZE remove redundant elements of path
%
% normalize(p) remove redundant elements of path p
% path need not exist, normalized path is returned
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
  backend (1,:) string = ["java", "python", "native"]
end

[fun, b] = hbackend(backend, "normalize");

if isscalar(file)
  n = fun(file);
else
  n = arrayfun(fun, file);
end

end
