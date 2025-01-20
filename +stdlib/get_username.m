%% GET_USERNAME tell username of current user
% requires: java
%
function n = get_username()

n = javaSystemProperty("user.name");

end

%!assert(!isempty(get_username()))
