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
  file {mustBeTextScalar,mustBeFolder}
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
