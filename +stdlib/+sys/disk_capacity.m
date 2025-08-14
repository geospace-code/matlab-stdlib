function [t, cmd] = disk_capacity(p)

t = uint64([]);

if ~stdlib.exists(p), return, end

if ispc()
  dl = extractBefore(stdlib.absolute(p), 2);
  cmd = sprintf('pwsh -c "(Get-Volume -DriveLetter ''%s'').Size"', dl);
elseif ismac()
  cmd = sprintf('df -k "%s" | awk ''NR==2 {print $2*1024}''', p);
else
  cmd = sprintf('df -B1 "%s" | awk ''NR==2 {print $2}''', p);
end

if stdlib.exists(p)
  [s, t] = system(cmd);
  if s == 0
    t = str2double(t);
  end
end

t = uint64(t);

end
