%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab
%
%% Inputs
% * file: path to symbolic link
% * backend: backend to use
%% Outputs
% * r: target of symbolic link
% * b: backend used

function [r, b] = read_symlink(file, backend)
arguments
  file string
  backend (1,:) string = ["native", "java", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "read_symlink", 'R2024b');

if isscalar(file) || b == "native"
  r = fun(file);
else
  r = arrayfun(fun, file);
end

end
