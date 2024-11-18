%% GET_SHELL shell of the current user
% return value of environment variable SHELL
% this is mostly relevant on unix-like systems

function shell = get_shell()

shell = string(getenv("SHELL"));

end
