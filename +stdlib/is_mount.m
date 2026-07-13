%% IS_MOUNT is filepath a mount path
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * ok: true if path is a mount point
% * b: backend used
%
% Examples:
%
% * Windows: is_mount('c:') false;  is_mount('C:\') true
% * Linux, macOS, Windows: is_mount('/') true

function [i, b] = is_mount(file, backend)
arguments
  file {mustBeTextScalar,mustBeFolder}
  backend (1,:) string = string.empty
end

[i, b] = getUsingBackend(backend, mfilename, file);

end
