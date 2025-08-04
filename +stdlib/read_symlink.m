%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab

function r = read_symlink(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["native", "java", "dotnet", "python", "sys"]
end

fun = hbackend(backend, "read_symlink", 'R2024b');

r = fun(file);

end
