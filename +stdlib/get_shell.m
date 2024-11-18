function shell = get_shell()
%% GET_SHELL shell of the current user
% return value of environment variable SHELL
% this is mostly relevant on unix-like systems

shell = string(getenv("SHELL"));

end
