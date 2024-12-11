%% WSLPATH2WINPATH convert a WSL path to a Windows path
%
% PATH MUST EXIST IN WSL
% output format is like \\wsl$\Ubuntu\home\username\...

function win_path = wslpath2winpath(wsl_path)
arguments
  wsl_path (1,1) string {mustBeNonzeroLengthText}
end

assert(stdlib.has_wsl(), "stdlib:sys:wslpath2winpath:EnvironmentError", mfilename() + "only supported on Windows Matlab with WSL")

[stat, win_path] = system("wsl wslpath -w " + wsl_path);

assert(stat == 0, "stdlib:sys:wslpath2winpath:IOError", "could not convert wslpath " + win_path)

win_path = strip(win_path);

end

%!testif 0
