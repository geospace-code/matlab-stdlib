function ok = has_wsl()
% HAS_WSL  Check if WSL is installed and notionally working

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
