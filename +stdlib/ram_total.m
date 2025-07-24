%% RAM_TOTAL get total physical RAM
%
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Outputs
% * bytes: total physical RAM [bytes]

function bytes = ram_total()


if stdlib.dotnet_api() >= 6
  % .NET is 2-3x faster than Java for this
  % https://learn.microsoft.com/en-us/dotnet/api/system.gcmemoryinfo.totalavailablememorybytes
  bytes = System.GC.GetGCMemoryInfo().TotalAvailableMemoryBytes;
elseif stdlib.has_java()
  bytes = ram_total_java();
else
  bytes = ram_total_system();
end

bytes = uint64(bytes);

end


function bytes = ram_total_system()

if ispc()
  cmd = 'pwsh -c "(Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory"';
elseif ismac()
  cmd = 'sysctl -n hw.memsize';
else
  cmd = "free -b | awk '/Mem:/ {print $4}'";
end

[s, m] = system(cmd);
if s == 0
  bytes = str2double(m);
end

end


function bytes = ram_total_java()
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalMemorySize()

b = javaMethod("getOperatingSystemMXBean", "java.lang.management.ManagementFactory");

if stdlib.java_api() < 14
  bytes = b.getTotalPhysicalMemorySize();
else
  bytes = b.getTotalMemorySize();
end

end

%!assert(ram_total()>0)
