function wsl_path = winpath2wslpath(win_path)
%% winpath2wslpath convert native Windows path to WSL path
arguments (Input)
  win_path (1,1) string {mustBeNonzeroLengthText}
end
arguments (Output)
  wsl_path (1,1) string {mustBeNonzeroLengthText}
end

assert(stdlib.sys.has_wsl(), "stdlib:sys:winpath2wslpath:EnvironmentError", mfilename() + "only supported on Windows Matlab with WSL")

[stat, wsl_path] = system("wsl wslpath " + strrep(win_path, '\', '/'));

assert(stat == 0, "stdlib:sys:winpath2wslpath:IOError", "could not convert wslpath " + wsl_path)

wsl_path = strip(wsl_path);

end
