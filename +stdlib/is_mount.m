%% IS_MOUNT is filepath a mount path
%
%% Inputs
% * filepath: path to check
% * backend: backend to use
%% Outputs
% * ok: true if path is a mount point
% * b: backend used
%
% Examples:
%
% * Windows: is_mount("c:") false;  is_mount("C:\") true
% * Linux, macOS, Windows: is_mount("/") true

function [ok, b] = is_mount(filepath, backend)
arguments
  filepath {mustBeTextScalar}
  backend (1,:) string = ["python", "sys"]
end

[fun, b] = hbackend(backend, "is_mount");

ok = fun(filepath);

end
