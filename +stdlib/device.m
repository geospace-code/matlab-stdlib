%% DEVICE filesystem device index of path
%
%% Inputs
% * file: path to file
%% Outputs
% * i: device index
% * b: backend used

function [i, b] = device(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "python", "sys"]
end

[fun, b] = hbackend(backend, "device");

i = fun(file);

end
