%% IS_REMOVABLE - Check if a file path is on a removable drive
% Not necessarily perfectly reliable at detection, but works for most cases.

function y  = is_removable(filepath, method)
arguments
  filepath {mustBeTextScalar}
  method (1,:) string = ["dotnet", "sys"]
end

fun = choose_method(method, "is_removable");

y = fun(filepath);

end
