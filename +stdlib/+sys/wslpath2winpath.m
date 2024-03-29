function win_path = wslpath2winpath(wsl_path)

arguments (Input)
  wsl_path (1,1) string {mustBeNonzeroLengthText}
end
arguments (Output)
  win_path (1,1) string {mustBeNonzeroLengthText}
end

assert(stdlib.sys.has_wsl(), "stdlib:sys:wslpath2winpath:EnvironmentError", mfilename() + "only supported on Windows Matlab with WSL")

[stat, win_path] = system("wsl wslpath -w " + wsl_path);

assert(stat == 0, "stdlib:sys:wslpath2winpath:IOError", "could not convert wslpath " + win_path)

win_path = strip(win_path);

end
