%% IS_MOUNT is filepath a mount path
%
% Examples:
%
% * Windows: is_mount("c:") false;  is_mount("C:\") true
% * Linux, macOS, Windows: is_mount("/") true

function y = is_mount(filepath, backend)
arguments
  filepath {mustBeTextScalar}
  backend (1,:) string = ["python", "sys"]
end

fun = hbackend(backend, "is_mount");
y = fun(filepath);

end
