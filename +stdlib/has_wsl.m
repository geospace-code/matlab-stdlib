%% HAS_WSL is Windows Subsystem for Linux installed
% Check if WSL is installed and notionally working

function ok = has_wsl()

persistent wsl;

if isempty(wsl)
  if ispc
    [stat, ~] = system("wsl test 1");
    wsl = stat == 0;
  else
    wsl = false;
  end
end

ok = wsl;

end
