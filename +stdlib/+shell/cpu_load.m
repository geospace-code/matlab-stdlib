function [i, cmd, m] = cpu_load()

if ispc()
  cmd = 'pwsh -c "Get-CimInstance -ClassName Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average"';
elseif ismac()
  cmd = 'sysctl -n vm.loadavg | awk ''{print $2}''';
else
  cmd = 'cat /proc/loadavg | awk ''{print $1}''';
end

[status, m] = system(cmd);
if status == 0
  i = str2double(m);

  if ispc()
    i = i / 100.;
  end
else
  i = missing;
end

end
