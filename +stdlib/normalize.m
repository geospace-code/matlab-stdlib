%% NORMALIZE remove redundant elements of path
% optional: mex
%
% normalize(p) remove redundant elements of path p
% path need not exist, normalized path is returned
%
%%% Inputs
% * p: path to normalize
%%% Outputs
% * c: normalized path
%
% MEX code is about 4-5x faster than plain Matlab below

function n = normalize(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:)string = ["java", "python", "native"]
end

fun = hbackend(backend, "normalize");

n = fun(file);

end
