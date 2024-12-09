%% GET_USERNAME tell username of current user

function n = get_username()

if stdlib.isoctave()
  n = javaMethod("getProperty", "java.lang.System", "user.name");
else
  n = string(java.lang.System.getProperty('user.name'));
end

end

%!assert(!isempty(get_username()))
