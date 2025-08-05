%% SYS.HARD_LINK_COUNT number of hard links to file
%
% Powershell is 0, 1, or 2

function n = hard_link_count(file)

if ~stdlib.exists(file)
  n = 0;
  return
end

if ispc()
  cmd = sprintf('pwsh -c "(Get-Item ''%s'').LinkType"', file);
elseif ismac()
  cmd = sprintf('stat -f %%l ''%s''', file);
else
  cmd = sprintf('stat -c %%h ''%s''', file);
end

[status, output] = system(cmd);
if status == 0
  if ispc()
    n = 1 + startsWith(output, "HardLink");
  else
    n = str2double(output);
  end
end

end
