%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: filesystem type
% * b: backend used

function [i, b] = filesystem_type(file, backend)
arguments
  file {mustBeTextScalar,mustBeFolder}
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
