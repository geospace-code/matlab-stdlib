%% IS_SYMLINK is path a symbolic link

function ok = is_symlink(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["native", "java", "dotnet", "python", "sys"]
end

fun = hbackend(backend, "is_symlink", 'R2024b');

ok = fun(file);

end
