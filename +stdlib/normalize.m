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
%
% MEX code is about 4-5x faster than plain Matlab below

function [n, b] = normalize(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "python", "native"]
end

[fun, b] = hbackend(backend, "normalize");

n = fun(file);

end
