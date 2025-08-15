%% IS_MOUNT is filepath a mount path
%
%% Inputs
% * file: path to check
% * backend: backend to use
%% Outputs
% * ok: true if path is a mount point
% * b: backend used
%
% Examples:
%
% * Windows: is_mount("c:") false;  is_mount("C:\") true
% * Linux, macOS, Windows: is_mount("/") true

function [ok, b] = is_mount(file, backend)
arguments
  file string
  backend (1,:) string = ["python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  ok = o.func(file);
else
  ok = arrayfun(o.func, file);
end

b = o.backend;

end
