%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...
%
%% Inputs
% * file: path to check
% * backend: backend to use
%% Outputs
% * t: filesystem type
% * b: backend used

function [t, b] = filesystem_type(file, backend)
arguments
  file
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "filesystem_type");

t = fun(file);

end
