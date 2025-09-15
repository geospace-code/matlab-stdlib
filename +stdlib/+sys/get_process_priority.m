function [i, cmd] = get_process_priority()

pid = stdlib.get_pid();

if ispc()
  cmd = sprintf('pwsh -c "(Get-Process -Id %d).PriorityClass"', pid);
else
  cmd = sprintf('ps -o ni= -p %d', pid);
end

[s, m] = system(cmd);
if s == 0
  if ispc()
    i = deblank(m);
  else
    i = str2double(m);
  end
else
  i = [];
end

end
