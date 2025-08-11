%% IS_SYMLINK is path a symbolic link
%
%% Inputs
% file: path to check
%% Outputs
% ok: true if path is a symbolic link
% b: backend used

function [ok, b] = is_symlink(file, backend)
arguments
  file string
  backend (1,:) string = ["native", "java", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "is_symlink", 'R2024b');

if isscalar(file) || b == "native"
  ok = fun(file);
else
  ok = arrayfun(fun, file);
end

end
