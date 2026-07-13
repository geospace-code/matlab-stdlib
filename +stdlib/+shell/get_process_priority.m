function [i, cmd] = get_process_priority()

pid = stdlib.get_pid();

if ispc()
  cmd = sprintf('pwsh -c "(Get-Process -Id %d).PriorityClass"', pid);
else  % Linux, macOS
  cmd = sprintf('ps -o pri= -p %d', pid);
end

[s, m] = system(cmd);
assert(s==0, "stdlib:shell:get_process_priority", "Failed to get process priority for PID %d using %s: %s ", pid, cmd, m);

if ispc()
  i = deblank(m);
else
  i = str2double(m);
end


end
