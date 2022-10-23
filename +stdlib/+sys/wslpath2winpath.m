function win_path = wslpath2winpath(wsl_path)
%% WSLPATH2WINPATH Convert a WSL path to a Windows path
% output format is like \\wsl$\Ubuntu\home\username\...
arguments
  wsl_path (1,1) string {mustBeNonzeroLengthText}
end

assert(stdlib.sys.has_wsl(), "stdlib:sys:wslpath2winpath:EnvironmentError", mfilename() + "only supported on Windows Matlab with WSL")

[stat, win_path] = system("wsl wslpath -w " + wsl_path);

assert(stat == 0, "stdlib:sys:wslpath2winpath:IOError", "could not convert wslpath " + win_path)

win_path = strip(string(win_path));

end
