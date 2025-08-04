function L = cpu_load()

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
  warning("stdlib:cpu_load:OSError", "Failed to get CPU load");
  return
end

L = str2double(strip(m));

if ispc()
  L = L / 100.;
end

end
