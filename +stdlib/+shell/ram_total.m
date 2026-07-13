function [bytes, cmd] = ram_total()

if ispc()
  cmd = 'pwsh -c "(Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory"';
elseif ismac()
  cmd = 'sysctl -n hw.memsize';
else
  cmd = 'free -b | awk ''/Mem:/ {print $2}''';
end

[s, m] = system(cmd);
assert(s == 0, 'stdlib:shell:ram_total', 'Error executing ram_total command %s: %s', cmd, m);
bytes = uint64(str2double(m));

end
