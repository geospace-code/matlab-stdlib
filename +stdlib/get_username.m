%% GET_USERNAME tell username of current user
% optional: java
%
function n = get_username()

if NET.isNETSupported
  n = System.Environment.UserName;
else
  n = javaMethod("getProperty", "java.lang.System", "user.name");
end

try  %#ok<*TRYNC>
  n = string(n);
end

end

%!assert(!isempty(get_username()))
