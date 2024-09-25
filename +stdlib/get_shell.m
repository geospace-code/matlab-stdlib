function shell = get_shell()
% return value of environment variable SHELL
% this is mostly relevant on unix-like systems

shell = string(getenv("SHELL"));

end