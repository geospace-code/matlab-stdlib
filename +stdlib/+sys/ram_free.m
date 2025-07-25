function bytes = ram_free()

bytes = 0;

if ispc()
  cmd = 'pwsh -c "(Get-CimInstance -ClassName CIM_OperatingSystem).FreePhysicalMemory * 1KB"';
elseif ismac()
  cmd = 'sysctl -n vm.page_free_count';
else
  cmd = "free -b | awk '/Mem:/ {print $4}'";
end

[s, m] = system(cmd);
if s == 0
  bytes = str2double(m);
  if ismac()
    bytes = bytes * 4096; % Assuming a page size of 4096 bytes
  end

end

bytes = uint64(bytes);

end
