%% DEVICE filesystem device index of path
%
%% Inputs
% * file: path to file
%% Outputs
% * i: device index
% * b: backend used

function [i, b] = device(file, backend)
arguments
  file
  backend (1,:) string = ["java", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
i = o.func(file);

b = o.backend;
end
