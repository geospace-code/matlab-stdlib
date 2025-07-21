%% GET_USERNAME tell username of current user
% optional: java
%
function n = get_username()

n = '';

if stdlib.has_dotnet()
  n = System.Environment.UserName;
elseif stdlib.has_java()
  n = javaMethod("getProperty", "java.lang.System", "user.name");
end

try  %#ok<*TRYNC>
  n = string(n);
end

end

%!assert(!isempty(get_username()))
