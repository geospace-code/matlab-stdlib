%% IS_ADMIN is the process run as root / admin

function y = is_admin(method)
arguments
  method (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = choose_method(method, "is_admin");

y = fun();

end

