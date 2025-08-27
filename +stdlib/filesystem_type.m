%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * t: filesystem type
% * b: backend used

function [t, b] = filesystem_type(file, backend)
arguments
  file
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
t = o.func(file);
b = o.backend;

end
