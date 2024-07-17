function iswps = is_windows_powershell()
%% is_windows_powershell()
% detects Windows powershell vs. Command Prompt
% Matlab on Windows Powershell vs Comspec for system()
% would impact syntax of some system() commands
%
% adapted from: https://stackoverflow.com/a/34480405/7703794

iswps = false;
if ~ispc
  return
end

[ret, ~] = system("dir 2>&1 *`");
iswps = ret == 0;

end
