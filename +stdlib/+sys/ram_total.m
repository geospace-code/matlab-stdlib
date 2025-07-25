function bytes = ram_total()

bytes = 0;

if ispc()
  cmd = 'pwsh -c "(Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory"';
elseif ismac()
  cmd = 'sysctl -n hw.memsize';
else
  cmd = "free -b | awk '/Mem:/ {print $2}'";
end

[s, m] = system(cmd);
if s == 0
  bytes = str2double(m);
end

bytes = uint64(bytes);

end
