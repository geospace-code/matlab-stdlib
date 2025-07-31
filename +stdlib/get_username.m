%% GET_USERNAME tell username of current user
%
function n = get_username(method)
arguments
  method (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = choose_method(method, "get_username");

n = fun();

end
