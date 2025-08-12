%% DISK_CAPACITY disk total capacity (bytes)
%
% example:  stdlib.disk_capacity('/')
%
%% Inputs
% * filepath: path to check
%% Outputs
% * f: total disk capacity (bytes)
% * b: backend used

function [f, b] = disk_capacity(filepath, backend)
arguments
  filepath
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "disk_capacity");

f = fun(filepath);

end
