%% IS_SYMLINK is path a symbolic link

function ok = is_symlink(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["native", "java", "dotnet", "python", "sys"]
end

fun = choose_method(method, "is_symlink", 'R2024b');

ok = fun(file);

end
