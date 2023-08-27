function win_path = wslpath2winpath(wsl_path)
%% wslpath2winpath(wsl_path)
% Convert a WSL path to a Windows path
% output format is like \\wsl$\Ubuntu\home\username\...
arguments (Input)
  wsl_path (1,1) string {mustBeNonzeroLengthText}
end
arguments (Output)
  win_path (1,1) string {mustBeNonzeroLengthText}
end

win_path = stdlib.sys.wslpath2winpath(wsl_path);

end
