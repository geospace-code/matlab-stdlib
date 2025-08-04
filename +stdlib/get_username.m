%% GET_USERNAME tell username of current user
%
function n = get_username(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = hbackend(backend, "get_username");

n = fun();

end
