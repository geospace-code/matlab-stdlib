%% WINPATH2WSLPATH convert Windows path to WSL path
% input format like \\wsl$\Ubuntu\home\username\...
function wsl_path = winpath2wslpath(win_path)
% arguments
%   win_path (1,1) string
% end

assert(stdlib.has_wsl(), "stdlib:sys:winpath2wslpath:EnvironmentError",  "%s only supported on Windows Matlab with WSL", mfilename())

cmd = "wsl wslpath ";

if ischar(win_path)
  cmd = strcat(cmd, strrep(win_path, '\', '/'));
else
  cmd = cmd + strrep(win_path, '\', '/');
end

[stat, wsl_path] = system(cmd);

assert(stat == 0, "stdlib:sys:winpath2wslpath:IOError", "could not convert wslpath %s", wsl_path)

try %#ok<TRYNC>
wsl_path = strip(wsl_path);
end

end

%!testif 0
