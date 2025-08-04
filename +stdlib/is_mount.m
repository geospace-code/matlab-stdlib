%% IS_MOUNT is filepath a mount path
% 
% Examples:
%
% * Windows: is_mount("c:") false;  is_mount("C:\") true
% * Linux, macOS, Windows: is_mount("/") true

function y = is_mount(filepath, method)
arguments 
  filepath {mustBeTextScalar}
  method (1,:) string = ["python", "sys"]
end

fun = choose_method(method, "is_mount");
y = fun(filepath);

end
