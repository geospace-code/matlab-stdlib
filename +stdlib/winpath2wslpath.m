function wsl_path = winpath2wslpath(win_path)
%% winpath2wslpath(win_path)
% Convert Windows path to WSL path
% input format like \\wsl$\Ubuntu\home\username\...
arguments
  win_path (1,1) string {mustBeNonzeroLengthText}
end

wsl_path = stdlib.sys.winpath2wslpath(win_path);

end
