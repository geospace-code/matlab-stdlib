%% DEVICE filesystem device index of path
%
%%% Inputs
% * file: path to file
% * backend: backend to use
%%% Outputs
% * i: device index
% * b: backend used

function [i, b] = device(file, backend)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
