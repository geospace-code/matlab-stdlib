%% WINPATH2WSLPATH convert Windows path to WSL path
% input format like \\wsl$\Ubuntu\home\username\...
function wsl_path = winpath2wslpath(win_path)
arguments
  win_path (1,1) string {mustBeNonzeroLengthText}
end


assert(stdlib.has_wsl(), "stdlib:sys:winpath2wslpath:EnvironmentError", mfilename() + "only supported on Windows Matlab with WSL")

[stat, wsl_path] = system("wsl wslpath " + strrep(win_path, '\', '/'));

assert(stat == 0, "stdlib:sys:winpath2wslpath:IOError", "could not convert wslpath " + wsl_path)

wsl_path = strip(wsl_path);

end
