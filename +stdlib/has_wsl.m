%% HAS_WSL is Windows Subsystem for Linux installed
% Check if WSL is installed and notionally working

function ok = has_wsl()

persistent wsl;

if isempty(wsl)
  wsl = false;
  if ispc
    [stat, ~] = system("wsl test 1");
    wsl = stat == 0;
  end
end

ok = wsl;

end

%!assert(islogical(has_wsl()))
