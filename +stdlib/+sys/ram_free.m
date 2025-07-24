function bytes = ram_free()

bytes = 0;

if ispc()
  cmd = 'pwsh -c "(Get-CimInstance -ClassName CIM_OperatingSystem).FreePhysicalMemory * 1KB"';
elseif ismac()
  cmd = 'sysctl -n hw.memsize';
else
  cmd = "free -b | awk '/Mem:/ {print $4}'";
end

[s, m] = system(cmd);
if s == 0
  bytes = str2double(m);
end

bytes = uint64(bytes);

end
