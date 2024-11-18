%% GET_USERNAME tell username of current user

function username = get_username()
username = string(java.lang.System.getProperty('user.name'));
end
