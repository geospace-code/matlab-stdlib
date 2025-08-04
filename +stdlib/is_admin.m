%% IS_ADMIN is the process run as root / admin

function y = is_admin(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = hbackend(backend, "is_admin");

y = fun();

end
