function [L, cmd, m] = cpu_load()

L = NaN;

if ispc()
  cmd = 'pwsh -c "Get-CimInstance -ClassName Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average"';
elseif ismac()
  cmd = "sysctl -n vm.loadavg | awk '{print $2}'";
else
  cmd = "cat /proc/loadavg | awk '{print $1}'";
end

[status, m] = system(cmd);
if status ~= 0
  return
end

L = str2double(m);

if ispc()
  L = L / 100.;
end

end
