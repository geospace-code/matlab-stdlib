%% READ_SYMLINK read symbolic link
%
% empty string if path is not a symlink
% always of string class in Matlab

function r = read_symlink(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["native", "java", "dotnet", "python", "sys"]
end

fun = choose_method(method, "read_symlink", 'R2024b');

r = fun(file);

end
