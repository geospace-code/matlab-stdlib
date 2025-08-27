%% DISK_CAPACITY disk total capacity (bytes)
%
% example:  stdlib.disk_capacity('/')
%
%%% inputs
% * file: path to check
%%% Outputs
% * f: total disk capacity (bytes)
% * b: backend used

function [i, b] = disk_capacity(file, backend)
arguments
  file
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
i = o.func(file);

b = o.backend;
end
