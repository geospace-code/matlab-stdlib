function username = get_username()
%% GET_USERNAME tell username of current user
username = string(java.lang.System.getProperty('user.name'));

end
