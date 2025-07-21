%% GET_USERNAME tell username of current user
% optional: java
%
function n = get_username()

if ispc()
  n = string(System.Environment.UserName);
else
  n = javaSystemProperty("user.name");
end

end

%!assert(!isempty(get_username()))
