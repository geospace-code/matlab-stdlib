%% GET_SHELL shell of the current user
% return value of environment variable SHELL
% this is mostly relevant on unix-like systems

function s = get_shell()

s = getenv("SHELL");

end

%!assert(ischar(get_shell()))
