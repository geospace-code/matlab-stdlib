%% shell.HARD_LINK_COUNT number of hard links to file
%
% Powershell is 0, 1, or 2

function [n, cmd] = hard_link_count(file)

n = missing;

if ispc()
  cmd = sprintf('pwsh -c "(Get-Item ''%s'').LinkType"', file);
elseif ismac()
  cmd = sprintf('stat -f %%l ''%s''', file);
else
  cmd = sprintf('stat -c %%h ''%s''', file);
end

[s, r] = system(cmd);
if s == 0
  if ispc()
    n = 1 + startsWith(r, "HardLink");
  else
    n = str2double(r);
  end
end

end
